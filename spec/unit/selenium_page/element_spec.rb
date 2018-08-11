# frozen_string_literal: true

describe SeleniumPage::Element do
  let(:driver) { instance_double(Selenium::WebDriver::Driver) }
  let(:base_element) { instance_double(Selenium::WebDriver::Element) }

  subject { SeleniumPage::Element.new(driver, base_element) }

  describe '.initialize' do
    context 'when driver is not a Selenium::WebDriver::Driver' do
      it 'raises error' do
        expect { subject }.to raise_error(
          SeleniumPage::Element::Errors::WrongDriver
        )
      end
    end

    context 'when base_element is not a Selenium::WebDriver::Element' do
      it 'raises error' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)

        expect { subject }.to raise_error(
          SeleniumPage::Element::Errors::WrongBaseElement
        )
      end
    end

    it 'assign instance variables' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      result = subject
      expect(result.instance_variable_get(:@driver)).to be driver
      expect(result.instance_variable_get(:@base_element)).to be base_element
    end
  end

  describe '#base_element' do
    it 'expose base element' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(subject.base_element).to be(base_element)
    end
  end

  describe '#driver' do
    it 'expose driver' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(subject.driver).to be(driver)
    end
  end

  describe '#method_missing' do
    context 'when the base element does not implement the method' do
      it 'raise error' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        expect { subject.not_existing_method }.to raise_error(NoMethodError)
      end
    end

    it 'delegate the method to the base element' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(base_element).to receive(:text)

      subject.text
    end

    it 'raise original error from the base element' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(base_element).to receive(:click)
        .and_raise(Selenium::WebDriver::Error::ElementNotVisibleError)

      expect { subject.click }
        .to raise_error(Selenium::WebDriver::Error::ElementNotVisibleError)
    end
  end

  describe '#respond_to?' do
    it 'return false if the method if it is not handled' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(subject.respond_to?(:not_existing_method)).to be false
    end

    it 'return true if base_element responds to the method' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(base_element).to receive(:respond_to?)
        .with(:click)
        .and_return(true)

      expect(subject.respond_to?(:click)).to be true
    end

    it 'return true if parent respond to the method' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(subject.respond_to?(:class)).to be true
    end
  end

  describe '#add_childrens' do
    
  end
end
