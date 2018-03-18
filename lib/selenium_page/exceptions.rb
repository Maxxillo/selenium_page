module SeleniumPage
  class WrongDriverError < StandardError
    def message
      'Only Selenium::WebDriver::Driver (or extensions) are accepted'
    end
  end
end
