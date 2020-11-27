# frozen_string_literal: true

RSpec.describe Puzzle, type: :model do
  subject { puzzle }

  let(:puzzle) { described_class.new(attributes) }

  let(:attributes) { {} }

  describe 'Validations' do
    context 'with shoulda matchers validations' do
      before { allow(puzzle).to receive(:ensure_random_name) }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.not_to validate_presence_of(:author) }
      it { is_expected.not_to validate_presence_of(:slug) }
    end

    context 'when definition is for a valid puzzle' do
      let(:attributes) { { definition: '0003000230004000' } }

      before { puzzle.valid? }

      it { expect(puzzle).to be_valid }
      it { expect(puzzle.errors).to be_blank }
    end

    context 'when definition is for an invalid puzzle' do
      let(:attributes) { { definition: nil } }

      before { puzzle.valid? }

      it { expect(puzzle).not_to be_valid }
      it { expect(puzzle.errors).to be_present }
    end

    context 'when name is not informed' do
      let(:attributes) { { definition: '0003000230004000', name: nil } }

      it 'generates a random name for the puzzle' do
        allow(Faker::Creature::Animal).to receive(:name).and_return('capybara')
        allow(Faker::Internet).to receive(:slug).and_return('lorem-ipsum')
        puzzle.valid?
        expect(puzzle.name).to eq 'Capybara Lorem Ipsum'
      end
    end

    context 'when puzzle exists and name is set to nil', :aggregate_failures do
      let(:attributes) { { definition: '0003000230004000', name: 'Some Name' } }

      it 'does not try to generate a name for the puzzle' do
        puzzle.save
        puzzle.name = nil
        expect(puzzle).not_to be_valid
        expect(puzzle.name).to be_nil
      end
    end
  end
end
