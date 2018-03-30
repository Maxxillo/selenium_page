# frozen_string_literal: true

module SeleniumPage
  # Page
  class Page
    # Errors
    class Errors
      # SchemeAndAuthorityNotSet
      class SchemeAndAuthorityNotSet < StandardError
        def message
          'Please set scheme_and_authority for SeleniumPage' \
          " with '.configure_scheme_and_authority'"
        end
      end

      # UnexpectedUrl
      class UnexpectedUrl < StandardError
        def message
          "Only 'String' are accepted as page_url parameter"
        end
      end

      # UrlNotSet
      class UrlNotSet < StandardError
        def message
          "Please set url for the page with '.set_url'"
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
