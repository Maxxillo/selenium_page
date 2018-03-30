# frozen_string_literal: true

describe SeleniumPage::Errors::UnexpectedSchemeAndAuthority do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message)
        .to eql("Only 'String' are accepted")
    end
  end
end
