# frozen_string_literal: true

describe SeleniumPage::Page::Errors::SchemeAndAuthorityNotSet do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message).to eql(
        'Please set scheme_and_authority for SeleniumPage' \
        " with '.configure_scheme_and_authority'"
      )
    end
  end
end

describe SeleniumPage::Page::Errors::UnexpectedUrl do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message).to eql(
        "Only 'String' are accepted as page_url parameter"
      )
    end
  end
end

describe SeleniumPage::Page::Errors::UrlNotSet do
  it 'inherits from StandardError' do
    expect(described_class.superclass).to be StandardError
  end

  describe '#message' do
    subject { described_class.new }

    it 'returns error message' do
      expect(subject.message).to eql(
        "Please set url for the page with '.set_url'"
      )
    end
  end
end

describe SeleniumPage::Page::Errors::WrongDriver do
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
