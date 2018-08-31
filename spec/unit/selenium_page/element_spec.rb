# frozen_string_literal: true

describe SeleniumPage::Element do
  let(:driver) { instance_double(Selenium::WebDriver::Driver) }
  let(:base_element) { instance_double(Selenium::WebDriver::Element) }

  let(:parent_selector) { '.parent_selector' }
  let(:children_name) { :children_name }
  let(:children_selector) { '.children_selector' }
  let(:block_childrens) do
    Proc.new { element :children_name, '.children_selector' }
  end

  let(:element_selector) { '.element_selector' }
  let(:element_base_element_1) { instance_double(Selenium::WebDriver::Element) }
  let(:element_base_element_2) { instance_double(Selenium::WebDriver::Element) }
  let(:element_instance_1) { instance_double(SeleniumPage::Element) }
  let(:element_instance_2) { instance_double(SeleniumPage::Element) }
  let(:collection_selector) { '.collection_selector' }
  let(:collection_base_elements) { [element_base_element_1, element_base_element_2] }
  let(:waiter) { Selenium::WebDriver::Wait.new }

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
    it 'assigns parent_selector' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      subject.add_childrens(parent_selector)

      expect(subject.instance_variable_get(:@parent_selector))
        .to be(parent_selector)
    end

    it 'evaluate the given block' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      expect(subject).to receive(:element)

      subject.add_childrens(parent_selector, &block_childrens)
    end
  end

  describe '.element' do
    context 'when block is given' do
      it 'create singleton method' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        subject.instance_variable_set(:@parent_selector, parent_selector)

        subject.element(children_name, children_selector, &block_childrens)

        expect(subject.respond_to?(children_name)).to be true

        # FIXME: there is something strange here ...
        # passing of block needs to be improved
        expect(subject).to receive(:find_element)
          .with(parent_selector + ' ' + children_selector)
          .and_return(true)

        subject.send(children_name)
      end
    end

    context 'when block is not given' do
      it 'create singleton method' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        subject.instance_variable_set(:@parent_selector, parent_selector)

        subject.element(children_name, children_selector)

        expect(subject.respond_to?(children_name)).to be true

        expect(subject).to receive(:find_element)
          .with(parent_selector + ' ' + children_selector)
          .and_return(true)

        subject.send(children_name)
      end
    end
  end

  describe '.elements' do
    context 'when block is given' do
      it 'create singleton method' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        subject.instance_variable_set(:@parent_selector, parent_selector)

        subject.elements(children_name, children_selector, &block_childrens)

        expect(subject.respond_to?(children_name)).to be true

        # FIXME: there is something strange here ...
        # passing of block needs to be improved
        expect(subject).to receive(:find_elements)
          .with(parent_selector + ' ' + children_selector)
          .and_return(true)

        subject.send(children_name)
      end
    end

    context 'when block is not given' do
      it 'create singleton method' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        subject.instance_variable_set(:@parent_selector, parent_selector)

        subject.elements(children_name, children_selector)

        expect(subject.respond_to?(children_name)).to be true

        expect(subject).to receive(:find_elements)
          .with(parent_selector + ' ' + children_selector)
          .and_return(true)

        subject.send(children_name)
      end
    end
  end

  describe '#find_element' do
    context 'when the timeout expires' do
      it 'raise the original timeout error' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
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
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      # FIXME: needed because new is mocked below (need better solution)
      target = subject

      expect(waiter).to receive(:until).and_call_original
      expect(driver).to receive(:find_element).with(:css, element_selector)
                                              .and_return(element_base_element_1)
      expect(SeleniumPage::Element).to receive(:new)
        .with(driver, element_base_element_1).and_return(element_instance_1)
      expect(element_instance_1).to receive(:add_childrens)
                                    .with(element_selector)

      expect(target.send(:find_element, element_selector, waiter, &block_childrens))
        .to be(element_instance_1)
    end
  end

  describe '#find_elements' do
    context 'when the timeout expires' do
      it 'raise the original timeout error' do
        expect(driver).to receive(:is_a?)
          .with(Selenium::WebDriver::Driver)
          .and_return(true)
        expect(base_element).to receive(:is_a?)
          .with(Selenium::WebDriver::Element)
          .and_return(true)

        expect(waiter).to receive(:until).and_call_original
        expect(driver).to receive(:find_elements)
          .with(:css, collection_selector)
          .and_raise(Selenium::WebDriver::Error::TimeOutError)
        allow(Time).to receive(:now).and_return(0)

        expect { subject.send(:find_elements, collection_selector, waiter) }
          .to raise_error(Selenium::WebDriver::Error::TimeOutError)
      end
    end

    it 'calls the Selenium::WebDriver::Driver wrapped in a wait' do
      expect(driver).to receive(:is_a?)
        .with(Selenium::WebDriver::Driver)
        .and_return(true)
      expect(base_element).to receive(:is_a?)
        .with(Selenium::WebDriver::Element)
        .and_return(true)

      # FIXME: needed because new is mocked below (need better solution)
      target = subject

      expect(waiter).to receive(:until).and_call_original
      expect(driver).to receive(:find_elements).with(:css, collection_selector)
                                              .and_return(collection_base_elements)

      expect(SeleniumPage::Element).to receive(:new)
        .with(driver, element_base_element_1).and_return(element_instance_1)
      expect(SeleniumPage::Element).to receive(:new)
        .with(driver, element_base_element_2).and_return(element_instance_2)

      expect(element_instance_1).to receive(:add_childrens)
                                    .with(collection_selector)
      expect(element_instance_2).to receive(:add_childrens)
                                    .with(collection_selector)

      expect(target.send(:find_elements, collection_selector, waiter, &block_childrens))
        .to eql([element_instance_1, element_instance_2])
    end
  end
end
