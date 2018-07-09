module SeleniumPage
  class Element
    def initialize(base_element)
      @base_element = base_element
    end

    attr_reader :base_element

    def method_missing(m, *args, &block)
      @base_element.send(m, *args, &block)
    # rescue the method not found and raise
    end
  end
end
