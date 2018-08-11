# frozen_string_literal: true

module SeleniumPage
  # Page
  class Element
    # Errors
    class Errors
      # WrongBaseElement
      class WrongBaseElement < StandardError
        def message
          "Only 'Selenium::WebDriver::Element' are accepted as base_element parameter"
        end
      end

      # WrongDriver
      class WrongDriver < StandardError
        def message
          "Only 'Selenium::WebDriver::Driver' are accepted as driver parameter"
        end
      end
    end
  end
end
