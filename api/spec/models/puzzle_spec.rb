# frozen_string_literal: true

RSpec.describe Puzzle, type: :model do
  subject { puzzle }

  let(:puzzle) { described_class.new(attributes) }

  let(:attributes) { {} }

  describe 'Validations' do
    it { is_expected.not_to validate_presence_of(:name) }
    it { is_expected.not_to validate_presence_of(:author) }
    it { is_expected.not_to validate_presence_of(:slug) }

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
  end
end
