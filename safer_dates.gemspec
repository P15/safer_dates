Gem::Specification.new do |s|
  s.name         = 'safer_dates'
  s.version      = '0.0.2'
  s.date         = '2015-06-03'
  s.summary      = 'Enforce ISO 8601 date and datetime parsing in Ruby'
  s.description  = "Allows users to remove methods such as Date.parse and\n" \
                   "DateTime.parse which are not very strict in terms of enforcing ISO 8601.\n" \
                   "Allows users to prevent rails from typecasting dates and datetimes if the\n" \
                   "string representation before typecasting does not conform to ISO 8601."
  s.authors      = ['Teddy Widom']
  s.email        = 'theodore.widom@gmail.com'
  s.homepage     = 'http://github.com/Recombine/safer_dates'
  s.license      = 'MIT'

  s.files        = Dir['lib/**/*']
  s.require_path = 'lib'
end
