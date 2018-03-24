# frozen_string_literal: true

module SeleniumPage
  # Page
  class Page
    require_relative 'page/exceptions'

    def self.configure_url(url)
      raise UnexpectedUrlError unless url.is_a? String
      
      @url = url
    end

    def self.url
      @url
    end

    def initialize(driver)
      raise WrongDriverError unless driver.is_a? Selenium::WebDriver::Driver

      @page = driver
    end

    def get
      raise UrlNotSetError unless self.class.url

      scheme_and_authority = SeleniumPage.scheme_and_authority
      raise SchemeAndAuthorityNotSetError unless scheme_and_authority

      @page.get scheme_and_authority + self.class.url
    end
  end
end
