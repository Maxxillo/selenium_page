# frozen_string_literal: true

module SeleniumPage
  # Inform that at the moment only the type String can be passed as a
  # Scheme + Authority
  # @see https://en.wikipedia.org/wiki/URL Wikipedia URL definition
  class UnexpectedSchemeAndAuthorityError < StandardError
    def message
      "Only 'String' are accepted"
    end
  end
end
