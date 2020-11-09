# frozen_string_literal: true

RSpec.describe Sudoku::Unit, type: :model do
  let(:unit) { described_class.new(index) }

  let(:index) { 0 }

  describe 'Ivar assignment' do
    it { expect(unit.instance_variable_get(:@cells)).to eq [] }
    it { expect(unit.instance_variable_get(:@index)).to eq index }
  end
end
