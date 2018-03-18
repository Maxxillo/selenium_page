# frozen_string_literal: true

module SeleniumPage
  # Page
  class Page
    # rubocop:disable Naming/AccessorMethodName
    def self.set_url(page_url)
      @url = page_url.to_s
    end
    # rubocop:enable Naming/AccessorMethodName

    # rubocop:disable Style/TrivialAccessors
    def self.url
      @url
    end
    # rubocop:enable Style/TrivialAccessors

    def initialize(driver)
      raise WrongDriverError unless driver.is_a? Selenium::WebDriver::Driver
      @page = driver
    end

    def load
      @page.get SeleniumPage.scheme_and_authority + self.class.url
    end
  end
end
