# frozen_string_literal: true

module Sudoku
  class Grid
    module Validator
      VALID_LENGTHS = [16, 81].freeze

      def valid?
        @errors = []

        validate_presence
        validate_length
        validate_digits
        validate_rows
        validate_cols
        validate_blocks

        @errors.empty?
      end

      def errors
        @errors
      end

      def formatted_errors
        errors.map do |error|
          I18n.t("sudoku_grid.validator.#{error[:name]}", error)
        end
      end

      private

      def validate_presence
        return if current_definition.present?

        @errors << { name: :empty_puzzle }
      end

      def validate_length
        return if VALID_LENGTHS.include?(cells.size)

        @errors << { name: :invalid_length, length: cells.size, valid_lengths: VALID_LENGTHS.join(', ') }
      end

      def validate_digits
        valid_digits = ([0] + numbers).map(&:to_s)
        invalid_digits = current_definition.split('').reject { |digit| valid_digits.include?(digit) }
        return if invalid_digits.blank?

        @errors << { name: :invalid_digits, digits: invalid_digits.join(', '), valid_digits: valid_digits.join(', ') }
      end

      def validate_rows
        rows.values.each(&method(:validate_unit))
      end

      def validate_cols
        cols.values.each(&method(:validate_unit))
      end

      def validate_blocks
        blocks.values.each(&method(:validate_unit))
      end

      def validate_unit(unit)
        numbers_count = unit.cells.map(&:value).tally
        duplicate_numbers = numbers_count.reject { |number, count| count <= 1 || number.nil? }.keys
        return if duplicate_numbers.empty?

        add_duplicate_unit_errors(unit, duplicate_numbers)
      end

      def add_duplicate_unit_errors(unit, duplicate_numbers)
        unit_type = unit.type
        duplicate_numbers.each do |duplicate|
          @errors << { name: "duplicate_in_#{unit_type}".to_sym, digit: duplicate }.tap do |error_hash|
            error_hash[unit_type.to_sym] = unit.name
          end
        end
      end
    end
  end
end
