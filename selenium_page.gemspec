# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'selenium_page'
  s.version     = '0.1.0'
  s.date        = '2018-03-16'
  s.summary     = 'A page object pattern gem for Selenium Webdriver!'
  s.description = 'A page object pattern gem for Selenium Webdriver!'
  s.authors     = ['Massimiliano De Vivo']
  s.email       = 'maxtru2005@gmail.com'
  s.files       = Dir.glob('lib/**/*') + %w[LICENSE.md README.md]
  s.homepage    = 'https://github.com/mooikos/selenium_page'
  s.license     = 'MIT'

  s.add_runtime_dependency 'selenium-webdriver', '>= 3.8.0'

  s.add_development_dependency 'chromedriver-helper', '>= 1.2.0'
  s.add_development_dependency 'pry-byebug', '>= 3.5.0'
  s.add_development_dependency 'rspec', '>= 3.7.0'
  s.add_development_dependency 'rubocop', '>= 0.53.0'
  s.add_development_dependency 'simplecov', '>= 0.16.0'
  s.add_development_dependency 'yard', '>= 0.9.0'
end
