# frozen_string_literal: true

describe SeleniumPage::Page do
  let(:scheme_and_authority) { 'http://localhost:8080' }
  let(:url) { '/about' }
  let(:driver) { instance_double('Selenium::WebDriver::Driver') }

  # reset the class state
  after do
    if described_class.instance_variable_defined?(:@url)
      described_class.remove_instance_variable(:@url)
    end
  end

  describe '.configure_url' do
    it 'sets @url' do
      described_class.configure_url(url)

      expect(described_class.instance_variable_get(:@url))
        .to eql(url)
    end

    context 'when not a String' do
      let(:url) { 12_345 }

      it 'raises error' do
        expect { described_class.configure_url(url) }
          .to raise_error(SeleniumPage::Page::Errors::UnexpectedUrl)
      end
    end
  end

  describe '.url' do
    it 'gets @url' do
      described_class.instance_variable_set(:@url, url)

      expect(described_class.url).to eql(url)
    end
  end

  describe '#initialize' do
    subject { described_class.new(driver) }

    it 'sets @page' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)

      expect(subject.instance_variable_get(:@page))
        .to be(driver)
    end

    context 'when not a Selenium::WebDriver::Driver' do
      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::WrongDriver
        )
      end
    end
  end

  describe '#url' do
    subject { described_class.new(driver) }

    it 'gets @url from the class' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)

      described_class.instance_variable_set(:@url, url)

      expect(subject.url).to eql(url)
    end
  end

  describe '#get' do
    subject { described_class.new(driver) }

    before do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
    end

    context 'when @url is set' do
      before do
        subject.class.instance_variable_set(:@url, url)
      end

      it 'calls @page.get' do
        expect(SeleniumPage).to receive(:scheme_and_authority)
          .and_return(scheme_and_authority)

        expect(driver).to receive(:get).with(
          scheme_and_authority + url
        )

        subject.get
      end

      context 'when SeleniumPage.scheme_and_authority is nil' do
        it 'raises error' do
          expect(SeleniumPage).to receive(:scheme_and_authority)

          expect { subject.get }.to raise_error(
            SeleniumPage::Page::Errors::SchemeAndAuthorityNotSet
          )
        end
      end
    end

    context 'when @url is not set' do
      it 'raises error' do
        expect { subject.get }.to raise_error(
          SeleniumPage::Page::Errors::UrlNotSet
        )
      end
    end
  end
end
