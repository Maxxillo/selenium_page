# frozen_string_literal: true

# external
require 'selenium-webdriver'

# SeleniumPage
module SeleniumPage
  require_relative 'selenium_page/exceptions'
  require_relative 'selenium_page/page'

  # naming from https://en.wikipedia.org/wiki/URL
  def self.configure_scheme_and_authority(scheme_and_authority)
    unless scheme_and_authority.is_a? String
      raise UnexpectedSchemeAndAuthorityError
    end

    @scheme_and_authority = scheme_and_authority
  end

  def self.scheme_and_authority
    @scheme_and_authority
  end
end
