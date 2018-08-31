# frozen_string_literal: true

module SeleniumPage
  # Element
  class Element
    require_relative 'element/errors'

    def initialize(driver, base_element)
      raise Errors::WrongDriver unless driver.is_a? Selenium::WebDriver::Driver
      unless base_element.is_a? Selenium::WebDriver::Element
        raise Errors::WrongBaseElement
      end

      @driver = driver
      @base_element = base_element
    end

    attr_reader :driver
    attr_reader :base_element

    def method_missing(called_method, *args, &block)
      # FIXME: should this catch some specific methods (to_s ?) ?
      if base_element.respond_to?(called_method)
        base_element.send(called_method, *args, &block)
      else
        super
      end
    end

    # this fix the calls to :respond_to? in case of delegation to base_element
    # the method will stay private
    # rubocop best practice suggestion
    def respond_to_missing?(called_method, *)
      base_element.respond_to?(called_method) || super
    end

    def add_childrens(parent_selector, &block)
      @parent_selector = parent_selector
      instance_exec(&block) if block_given?
    end

    def element(element_name, element_selector, &block)
      define_singleton_method(element_name) do
        selector = @parent_selector + ' ' + element_selector
        if block_given?
          find_element(selector, &block)
        else
          find_element(selector)
        end
      end
    end

    def elements(collection_name, collection_selector, &block)
      define_singleton_method(collection_name) do
        selector = @parent_selector + ' ' + collection_selector
        if block_given?
          find_elements(selector, &block)
        else
          find_elements(selector)
        end
      end
    end

    private

    def find_element(element_selector,
                     waiter = Selenium::WebDriver::Wait.new(
                       timeout: SeleniumPage.wait_time
                     ), &block)
      waiter.until do
        result = SeleniumPage::Element.new(
          @driver, @driver.find_element(:css, element_selector)
        )
        result.add_childrens(element_selector, &block)
        result
      end
    end

    # rubocop:disable Metrics/MethodLength
    def find_elements(collection_selector,
                      waiter = Selenium::WebDriver::Wait.new(
                        timeout: SeleniumPage.wait_time
                      ), &block)
      waiter.until do
        selenium_result = @driver.find_elements(:css, collection_selector)
        result = []
        selenium_result.each do |selenium_element|
          result << SeleniumPage::Element.new(@driver, selenium_element)
        end
        result.each do |selenium_page_element|
          selenium_page_element.add_childrens(collection_selector, &block)
        end
        result
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
