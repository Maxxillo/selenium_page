# frozen_string_literal: true

describe SeleniumPage::Element::Errors::WrongBaseElement do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message).to eql(
        "Only 'Selenium::WebDriver::Element' are accepted as base_element parameter"
      )
    end
  end
end

describe SeleniumPage::Element::Errors::WrongDriver do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message).to eql(
        "Only 'Selenium::WebDriver::Driver' are accepted as driver parameter"
      )
    end
  end
end
