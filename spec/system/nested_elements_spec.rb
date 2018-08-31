# frozen_string_literal: true

describe 'nested elements' do
  let(:driver) { instance_double(Selenium::WebDriver::Driver) }
  let(:outer_name_selector) { 'outer_name selector' }
  let(:inner_name_one_selector) { 'inner_name_one selector' }
  let(:inner_name_two_selector) { 'inner_name_two selector' }
  let(:inner_name_three_selector) { 'inner_name_three selector' }
  let(:outer_name_selenium) { instance_double(Selenium::WebDriver::Element) }
  let(:inner_name_one_selenium) do
    instance_double(Selenium::WebDriver::Element)
  end
  let(:inner_name_two_selenium) do
    instance_double(Selenium::WebDriver::Element)
  end
  let(:inner_name_three_selenium) do
    instance_double(Selenium::WebDriver::Element)
  end

  it 'do something' do
    require_relative 'support/myweb'

    driver = instance_double(Selenium::WebDriver::Driver)
    allow(driver).to receive(:is_a?)
      .with(Selenium::WebDriver::Driver)
      .and_return true

    myweb = MyWeb.new(driver)

    expect(myweb).to respond_to(:outer_name)

    expect(driver).to receive(:find_element)
      .with(:css, outer_name_selector)
      .and_return(outer_name_selenium)
    expect(outer_name_selenium).to receive(:is_a?)
      .with(Selenium::WebDriver::Element)
      .and_return true

    outer_name = myweb.outer_name

    expect(outer_name).to be_a(SeleniumPage::Element)
    expect(outer_name.base_element).to be(outer_name_selenium)

    expect(driver).to receive(:find_element)
      .with(:css, outer_name_selector + ' ' + inner_name_one_selector)
      .and_return(inner_name_one_selenium)

    inner_name_one = outer_name.inner_name_one

    expect(inner_name_one).to be_a(SeleniumPage::Element)
    expect(inner_name_one.base_element).to be(inner_name_one_selenium)

    expect(driver).to receive(:find_element)
      .with(:css, outer_name_selector +
                  ' ' + inner_name_one_selector +
                  ' ' + inner_name_two_selector)
      .and_return(inner_name_two_selenium)

    inner_name_two = inner_name_one.inner_name_two

    expect(inner_name_two).to be_a(SeleniumPage::Element)
    expect(inner_name_two.base_element).to be(inner_name_two_selenium)

    expect(driver).to receive(:find_element)
      .with(:css, outer_name_selector +
                  ' ' + inner_name_one_selector +
                  ' ' + inner_name_three_selector)
      .and_return(inner_name_three_selenium)

    inner_name_three = inner_name_one.inner_name_three

    expect(inner_name_three).to be_a(SeleniumPage::Element)
    expect(inner_name_three.base_element).to be(inner_name_three_selenium)
  end
end
