# frozen_string_literal: true

describe SeleniumPage::Element do

  let(:base_element_bridge) { instance_double(Selenium::WebDriver::Remote::Bridge) }
  let(:base_element_id) { String.new }
  let(:base_element) { Selenium::WebDriver::Element.new(base_element_bridge, base_element_id) }

  subject { SeleniumPage::Element.new(base_element) }

  it 'expose the base element' do
    expect(subject.base_element).to be(base_element)
  end

  it 'pass the methods to the base element' do
    expect(base_element).to receive(:text)

    subject.text
  end

  it 'raise original error from the base element' do
    allow(base_element).to receive(:click)
      .and_raise(Selenium::WebDriver::Error::ElementNotVisibleError)

    expect { subject.click }.to raise_error(Selenium::WebDriver::Error::ElementNotVisibleError)
  end

  it 'raise error if method is not found' do
    expect { subject.not_existing }.to raise_error(NoMethodError)
  end
end
