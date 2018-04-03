# frozen_string_literal: true

# external
require 'selenium-webdriver'

# SeleniumPage
module SeleniumPage
  require_relative 'selenium_page/errors'
  require_relative 'selenium_page/page'

  @wait_time = 10

  def self.configure_scheme_and_authority(scheme_and_authority)
    unless scheme_and_authority.is_a? String
      raise Errors::UnexpectedSchemeAndAuthority
    end

    @scheme_and_authority = scheme_and_authority
  end

  def self.scheme_and_authority
    @scheme_and_authority
  end

  def self.configure_wait_time(wait_time)
    raise Errors::UnexpectedWaitTime unless wait_time.is_a? Numeric

    @wait_time = wait_time
  end

  def self.wait_time
    @wait_time
  end
end
