# frozen_string_literal: true

module SeleniumPage
  # UnexpectedSchemeAndAuthority
  class UnexpectedSchemeAndAuthority < StandardError
    def message
      "Only 'String' are accepted"
    end
  end
end
