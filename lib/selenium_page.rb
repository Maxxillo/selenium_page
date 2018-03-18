# frozen_string_literal: true

require 'selenium_page/exceptions'

# SeleniumPage
module SeleniumPage
  autoload :Page, 'selenium_page/page'

  # NOTE: reference
  # https://en.wikipedia.org/wiki/URL
  # rubocop:disable Style/ClassVars
  def self.configure_scheme_and_authority(scheme_and_authority)
    @@scheme_and_authority = scheme_and_authority.to_s
  end
  # rubocop:enable Style/ClassVars

  def self.scheme_and_authority
    @@scheme_and_authority
  end
end
