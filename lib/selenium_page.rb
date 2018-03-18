require 'selenium_page/exceptions'

# SeleniumPage
module SeleniumPage
  autoload :Page, 'selenium_page/page'

  # NOTE: reference
  # https://en.wikipedia.org/wiki/URL
  def self.configure_scheme_and_authority(scheme_and_authority)
    @@scheme_and_authority = scheme_and_authority.to_s
  end

  def self.scheme_and_authority
    @@scheme_and_authority
  end
end
