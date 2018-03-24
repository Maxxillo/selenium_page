# frozen_string_literal: true

module SeleniumPage
  class Page
    # SchemeAndAuthorityNotSetError
    class SchemeAndAuthorityNotSetError < StandardError
      def message
        'Please set scheme_and_authority for SeleniumPage' \
        " with '.configure_scheme_and_authority'"
      end
    end

    # UnexpectedUrl
    class UnexpectedUrlError < StandardError
      def message
        "Only 'String' are accepted as page_url parameter"
      end
    end

    # UrlNotSetError
    class UrlNotSetError < StandardError
      def message
        "Please set url for the page with '.set_url'"
      end
    end

    # WrongDriverError
    class WrongDriverError < StandardError
      def message
        "Only 'Selenium::WebDriver::Driver' are accepted as driver parameter"
      end
    end
  end
end
