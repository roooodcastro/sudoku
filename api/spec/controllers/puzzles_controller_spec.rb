# frozen_string_literal: true

RSpec.describe PuzzlesController, type: :controller, aggregate_failures: true do
  describe 'GET index' do
    before do
      puzzle
      get :index, format: :json
    end

    let(:puzzle) { create :puzzle }

    it 'returns all puzzles in JSON format' do
      expect(response).to have_http_status(:success)
      expect(json_response['puzzles']).to eq [puzzle.as_json]
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: puzzle.id }, format: :json
    end

    let(:puzzle) { create :puzzle }

    it 'returns the puzzle in JSON format' do
      expect(response).to have_http_status(:success)
      expect(json_response['puzzle']).to eq puzzle.as_json
    end
  end

  describe 'POST create' do
    subject(:create_request) { post :create, params: { puzzle: puzzle_params }, format: :json }

    context 'with valid params' do
      let(:puzzle_params) do
        {
          name:       'MyPuzzle',
          author:     'Myself',
          definition: '123456789'
        }
      end

      it 'creates the puzzle and returns it in JSON format' do
        expect { create_request }.to change { Puzzle.count }.by(1)
        expect(response).to have_http_status(:success)

        expect(json_response['puzzle']['name']).to eq 'MyPuzzle'
        expect(json_response['puzzle']['author']).to eq 'Myself'
        expect(json_response['puzzle']['definition']).to eq '123456789'
      end
    end

    context 'with invalid params' do
      let(:puzzle_params) do
        {
          name:   'MyPuzzle',
          author: 'Myself'
        }
      end

      it 'does not create a puzzle but returns it in JSON format with the errors' do
        expect { create_request }.not_to(change { Puzzle.count })
        expect(response).to have_http_status(:unprocessable_entity)

        expect(json_response['puzzle']['name']).to eq 'MyPuzzle'
        expect(json_response['puzzle']['author']).to eq 'Myself'
        expect(json_response['errors']).to eq ['Definition can\'t be blank']
      end
    end
  end

  describe 'PATCH update' do
    subject(:patch_request) { patch :update, params: { id: puzzle.id, puzzle: puzzle_params }, format: :json }

    let(:puzzle) { create :puzzle }

    context 'with valid params' do
      let(:puzzle_params) do
        {
          name: 'MyPuzzle'
        }
      end

      it 'updates the puzzle and returns it in JSON format' do
        expect { patch_request }.to change { puzzle.reload.name }.from(nil).to('MyPuzzle')

        expect(response).to have_http_status(:success)
        expect(json_response['puzzle']).to eq puzzle.reload.as_json
      end
    end

    context 'with invalid params' do
      let(:puzzle_params) do
        {
          name:       'MyPuzzle',
          definition: ''
        }
      end

      it 'does not create a puzzle but returns it in JSON format with the errors' do
        expect { patch_request }.not_to(change { puzzle.reload.name })
        expect(response).to have_http_status(:unprocessable_entity)

        expect(json_response['puzzle']['name']).to eq 'MyPuzzle'
        expect(json_response['puzzle']['definition']).to eq ''
        expect(json_response['errors']).to eq ['Definition can\'t be blank']
      end
    end
  end
end
