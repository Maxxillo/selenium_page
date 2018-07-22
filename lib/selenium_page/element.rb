# frozen_string_literal: true

module SeleniumPage
  # Element
  class Element
    def initialize(base_element)
      # FIXME: base element needs to be a Selenium::WebDriver::Element
      @base_element = base_element
    end

    attr_reader :base_element

    def method_missing(called_method, *args, &block)
      binding.pry
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
      binding.pry
      instance_exec(parent_selector, &block)
    end

    def element(element_name, element_selector, *args, &block)
      binding.pry
      define_singleton_method(element_name) {
        binding.pry
        find_element(element_selector, &block)
      }
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
