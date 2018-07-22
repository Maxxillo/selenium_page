# frozen_string_literal: true

# # Timeout = 15 sec
# wait = Selenium::WebDriver::Wait.new(:timeout => 15)

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

    def self.element(element_name, element_selector, &block)
      # block_given?
      binding.pry
      raise Errors::UnexpectedElementName unless element_name.is_a?(Symbol)
      if method_defined?(element_name)
        raise Errors::AlreadyDefinedElementName, element_name
      end
      unless element_selector.is_a?(String)
        raise Errors::UnexpectedElementSelector
      end

      # the method will need to be moved to a module maybe ? and injected into page and element ?
      define_method(element_name) {
        binding.pry
        find_element(element_selector, &block)
      }
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

    private

    def find_element(element_selector,
                     waiter = Selenium::WebDriver::Wait.new(
                       timeout: SeleniumPage.wait_time
                     ), &block)
                     binding.pry
      waiter.until do
        result = SeleniumPage::Element.new(@page.find_element(:css, element_selector))
        binding.pry
        result.element(element_selector, &block)
      end
    end
  end
end
