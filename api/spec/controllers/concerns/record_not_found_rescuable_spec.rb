# frozen_string_literal: true

RSpec.describe RecordNotFoundRescuable, type: :controller, aggregate_failures: true do
  subject(:show_request) { get :show, params: { id: record_id }, format: :json }

  controller ApplicationController do
    include RecordNotFoundRescuable

    def show
      Puzzle.find(params[:id])
      render json: { success: true }, status: :ok
    end

    def controller_name
      'puzzle'
    end
  end

  before do
    routes.draw { get 'show' => 'anonymous#show' }
  end

  context 'when record being fetched exists' do
    let(:record) { create :puzzle }
    let(:record_id) { record.id }

    it 'returns the record in JSON format' do
      show_request

      expect(response).to have_http_status(:success)
      expect(json_response).to eq('success' => true)
    end
  end

  context 'when record being fetched does not exist' do
    let(:record_id) { 1234 }

    it 'returns an error in JSON format' do
      show_request

      expect(response).to have_http_status(:not_found)
      expect(json_response).to eq('error' => 'Puzzle not found')
    end
  end
end
