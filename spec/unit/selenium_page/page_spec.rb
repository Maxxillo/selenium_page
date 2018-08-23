# frozen_string_literal: true

describe SeleniumPage::Page do
  let(:scheme_and_authority) { 'http://localhost:8080' }
  let(:url) { '/about' }
  let(:driver) { instance_double(Selenium::WebDriver::Driver) }
  let(:element_name) { :label_info }
  let(:element_selector) { '#element_id' }
  let(:element_base_element) { instance_double(Selenium::WebDriver::Element) }
  let(:element_instance) { instance_double(SeleniumPage::Element) }
  let(:collection_name) { :list_result }
  let(:collection_selector) { 'a.collection_class' }
  let(:waiter) { Selenium::WebDriver::Wait.new }
  let(:block_childrens) { {} }

  # reset the class state
  after do
    if described_class.instance_variable_defined?(:@url)
      described_class.remove_instance_variable(:@url)
    end
    if described_class.method_defined?(element_name)
      described_class.remove_method(element_name)
    end
  end

  describe '.configure_url' do
    subject { described_class.configure_url(url) }

    context 'when not a String' do
      let(:url) { 12_345 }

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::UnexpectedUrl
        )
      end
    end

    it 'sets @url' do
      subject

      expect(described_class.instance_variable_get(:@url))
        .to eql(url)
    end
  end

  describe '.url' do
    it 'gets @url' do
      described_class.instance_variable_set(:@url, url)

      expect(described_class.url).to eql(url)
    end
  end

  describe '.element' do
    subject { described_class.element(element_name, element_selector) }

    context 'when element_name not a symbol' do
      let(:element_name) { 'element_name' }

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::UnexpectedElementName
        )
      end
    end

    context 'when element_name already defined' do
      before do
        described_class.define_method(element_name) {}
      end

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::AlreadyDefinedElementName,
          /#{element_name}/
        )
      end
    end

    context 'when element_selector not a string' do
      let(:element_selector) { 12_345 }

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::UnexpectedElementSelector
        )
      end
    end

    it 'creates an instance method with element_name' do
      subject

      expect(described_class.method_defined?(element_name)).to be true
    end
  end

  describe '.elements' do
    subject { described_class.elements(collection_name, collection_selector) }

    context 'when collection_name not a symbol' do
      let(:collection_name) { 'collection_name' }

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::UnexpectedElementName
        )
      end
    end

    context 'when collection_name already defined' do
      before do
        described_class.define_method(collection_name) {}
      end

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::AlreadyDefinedElementName,
          /#{collection_name}/
        )
      end
    end

    context 'when collection_selector not a string' do
      let(:collection_selector) { 12_345 }

      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::UnexpectedElementSelector
        )
      end
    end

    it 'creates an instance method with collection_name' do
      subject

      expect(described_class.method_defined?(collection_name)).to be true
    end
  end

  describe '#initialize' do
    subject { described_class.new(driver) }

    context 'when not a Selenium::WebDriver::Driver' do
      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Page::Errors::WrongDriver
        )
      end
    end

    it 'sets @driver' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)

      expect(subject.instance_variable_get(:@driver))
        .to be(driver)
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

    context 'when @url is not set' do
      it 'raises error' do
        expect { subject.get }.to raise_error(
          SeleniumPage::Page::Errors::UrlNotSet
        )
      end
    end

    context 'when @url is set' do
      before do
        subject.class.instance_variable_set(:@url, url)
      end

      context 'when SeleniumPage.scheme_and_authority is nil' do
        before do
          subject.class.instance_variable_set(:@url, url)
        end

        it 'raises error' do
          expect(SeleniumPage).to receive(:scheme_and_authority)

          expect { subject.get }.to raise_error(
            SeleniumPage::Page::Errors::SchemeAndAuthorityNotSet
          )
        end
      end

      it 'calls @driver.get' do
        expect(SeleniumPage).to receive(:scheme_and_authority)
          .and_return(scheme_and_authority)

        expect(driver).to receive(:get).with(
          scheme_and_authority + url
        )

        subject.get
      end
    end
  end

  describe '#(element_name)' do
    subject { described_class.new(driver) }

    context 'when without a block' do
      before do
        described_class.element(element_name, element_selector)
      end

      it 'calls the Selenium::WebDriver::Driver correctly' do
        expect(driver).to receive(:is_a?).with(Selenium::WebDriver::Driver)
                                         .and_return(true)
        expect(subject).to receive(:find_element).with(element_selector)
                                                 .and_return(element_instance)

        expect(subject.send(element_name))
          .to eql(element_instance)
      end
    end

    context 'when without a block' do
      before do
        described_class.element(element_name, element_selector, &block_childrens)
      end

      it 'calls the Selenium::WebDriver::Driver correctly' do
        expect(driver).to receive(:is_a?).with(Selenium::WebDriver::Driver)
                                         .and_return(true)
        expect(subject).to receive(:find_element).with(element_selector, &block_childrens)
                                                 .and_return(element_instance)

        expect(subject.send(element_name))
          .to eql(element_instance)
      end
    end
  end

  describe '#find_element' do
    subject do
      described_class.new(driver)
    end

    context 'when the timeout expires' do
      it 'raise the original timeout error' do
        expect(driver).to receive(:is_a?).with(Selenium::WebDriver::Driver)
                                         .and_return(true)

        expect(waiter).to receive(:until).and_call_original
        expect(driver).to receive(:find_element)
          .with(:css, element_selector)
          .and_raise(Selenium::WebDriver::Error::TimeOutError)
        allow(Time).to receive(:now).and_return(0)

        expect { subject.send(:find_element, element_selector, waiter) }
          .to raise_error(Selenium::WebDriver::Error::TimeOutError)
      end
    end

    it 'calls the Selenium::WebDriver::Driver wrapped in a wait' do
      expect(driver).to receive(:is_a?).with(Selenium::WebDriver::Driver)
                                       .and_return(true)

      expect(waiter).to receive(:until).and_call_original
      expect(driver).to receive(:find_element).with(:css, element_selector)
                                              .and_return(element_base_element)
      expect(SeleniumPage::Element).to receive(:new)
        .with(driver, element_base_element).and_return(element_instance)
      expect(element_instance).to receive(:add_childrens)
                                    .with(element_selector, &block_childrens)

      expect(subject.send(:find_element, element_selector, waiter, &block_childrens))
        .to be(element_instance)
    end
  end
end
