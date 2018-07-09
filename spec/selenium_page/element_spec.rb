# frozen_string_literal: true

describe SeleniumPage::Element do
  # let(:bridge) { instance_double(Selenium::WebDriver::Remote::Bridge) }
  # let(:id) { instance_double(String)}

  let(:base_element) { instance_double(Selenium::WebDriver::Element) }

  subject { SeleniumPage::Element.new(base_element) }

  it 'expose the base element' do
    expect(subject.base_element).to be(base_element)
  end

  it 'pass the methods to the base element' do
    expect(base_element).to receive(:text)
    
    subject.text
  end
end
