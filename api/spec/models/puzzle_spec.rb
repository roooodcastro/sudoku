# frozen_string_literal: true

RSpec.describe Puzzle, type: :model do
  subject { puzzle }

  let(:puzzle) { described_class.new(attributes) }

  let(:attributes) { {} }

  describe 'Validations' do
    it { is_expected.not_to validate_presence_of(:name) }
    it { is_expected.not_to validate_presence_of(:author) }
    it { is_expected.not_to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:definition) }
  end
end
