module SeleniumPage
  class Page
    def self.set_url(page_url)
      @url = page_url.to_s
    end

    def self.url
      @url
    end

    def initialize(driver)
      raise WrongDriverError unless driver.is_a? Selenium::WebDriver::Driver
      @page = driver
    end

    def load
      @page.get SeleniumPage.scheme_and_authority + self.class.url
    end
  end
end
