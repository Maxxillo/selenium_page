# frozen_string_literal: true

module SeleniumPage
  # Element
  class Element
    def initialize(base_element)
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
  end
end
