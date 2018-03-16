# SeleniumPage
class SeleniumPage
  def self.hi(language = 'english')
    translator = Translator.new(language)
    translator.hi
  end
end

require 'selenium_page/translator'
