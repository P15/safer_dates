$:.push File.expand_path('../lib', __FILE__)
require 'safer_dates/version'

Gem::Specification.new do |s|
  s.name         = 'safer_dates'
  s.version      = SaferDates::VERSION
  s.date         = Time.now.utc.strftime("%Y-%m-%d")
  s.summary      = 'Enforce ISO 8601 date and datetime parsing in Ruby'
  s.description  = "Allows users to remove methods such as Date.parse and\n" \
                   "DateTime.parse which are not very strict in terms of enforcing ISO 8601.\n" \
                   "Allows users to prevent rails from typecasting dates and datetimes if the\n" \
                   "string representation before typecasting does not conform to ISO 8601."
  s.authors      = ['Teddy Widom']
  s.email        = 'theodore.widom@gmail.com'
  s.homepage     = 'http://github.com/Recombine/safer_dates'
  s.license      = 'MIT'


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency('activerecord', '4.1.10')
end
