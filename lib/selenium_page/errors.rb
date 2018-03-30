# frozen_string_literal: true

module SeleniumPage
  # Errors
  class Errors
    # UnexpectedSchemeAndAuthority
    class UnexpectedSchemeAndAuthority < StandardError
      def message
        "Only 'String' are accepted"
      end
    end
  end
end
