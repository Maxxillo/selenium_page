# frozen_string_literal: true

# external
require 'selenium-webdriver'

# SeleniumPage
module SeleniumPage
  require_relative 'selenium_page/errors'
  require_relative 'selenium_page/page'

  def self.configure_scheme_and_authority(scheme_and_authority)
    unless scheme_and_authority.is_a? String
      raise Errors::UnexpectedSchemeAndAuthority
    end

    @scheme_and_authority = scheme_and_authority
  end

  def self.scheme_and_authority
    @scheme_and_authority
  end
end
