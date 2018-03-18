# frozen_string_literal: true

module SeleniumPage
  # WrongDriverError
  class WrongDriverError < StandardError
    def message
      'Only Selenium::WebDriver::Driver (or extensions) are accepted'
    end
  end
end
