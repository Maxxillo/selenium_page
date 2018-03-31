# frozen_string_literal: true

module SeleniumPage
  # Page
  class Page
    require_relative 'page/errors'

    def self.configure_url(url)
      raise Errors::UnexpectedUrl unless url.is_a? String

      @url = url
    end

    def self.url
      @url
    end

    def self.element(element_name)
      unless element_name.is_a? Symbol
        raise Errors::UnexpectedElementName
      end
      if self.method_defined?(element_name)
        raise Errors::AlreadyDefinedElementName.new(element_name)
      end
      define_method(element_name) { }
    end

    def initialize(driver)
      raise Errors::WrongDriver unless driver.is_a? Selenium::WebDriver::Driver

      @page = driver
    end

    def url
      self.class.url
    end

    def get
      raise Errors::UrlNotSet unless self.class.url

      scheme_and_authority = SeleniumPage.scheme_and_authority
      raise Errors::SchemeAndAuthorityNotSet unless scheme_and_authority

      @page.get scheme_and_authority + self.class.url
    end
  end
end
