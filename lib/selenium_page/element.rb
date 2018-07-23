# frozen_string_literal: true

module SeleniumPage
  # Element
  class Element
    def initialize(driver, base_element)
      raise Errors::WrongDriver unless driver.is_a? Selenium::WebDriver::Driver
      @page = driver
      # FIXME: base element needs to be a Selenium::WebDriver::Element
      @base_element = base_element
    end

    attr_reader :base_element

    def method_missing(called_method, *args, &block)
      # FIXME: this should catch some specific methods (to_s ?)
      if base_element.respond_to?(called_method)
        base_element.send(called_method, *args, &block)
      else
        super
      end
    end

    # rubocop best practice suggestion
    def respond_to_missing?(called_method, *)
      base_element.respond_to?(called_method) || super
    end

    def add_children(parent_selector, &block)
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

    private

    def find_element(element_selector,
                     waiter = Selenium::WebDriver::Wait.new(
                       timeout: SeleniumPage.wait_time
                     ), &block)
      waiter.until do
        result = SeleniumPage::Element.new(
          @page, @page.find_element(:css, element_selector)
        )
        result.add_children(element_selector, &block)
        result
      end
    end
  end
end
