# frozen_string_literal: true

module RecordNotFoundRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def record_not_found
    render json: { error: "#{controller_name.titleize} not found" }, status: :not_found
  end
end
