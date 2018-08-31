# frozen_string_literal: true

class MyWeb < SeleniumPage::Page
  configure_url '/home'

  element :outer_name, 'outer_name selector' do
    element :inner_name_one, 'inner_name_one selector' do
      element :inner_name_two, 'inner_name_two selector'
      element :inner_name_three, 'inner_name_three selector'
    end
  end
end
