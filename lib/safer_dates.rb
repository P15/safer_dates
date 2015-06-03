require_relative 'safer_dates/enforcers/date_dot_parse'
require_relative 'safer_dates/enforcers/datetime_dot_parse'
require_relative 'safer_dates/enforcers/attribute_typecasting'

module SaferDates
  def self.disable_date_dot_parse
    DateDotParse.disable!
  end

  def self.disable_datetime_dot_parse
    DateTimeDotParse.disable!
  end

  def self.disable_non_iso_8601_date_attribute_parsing
    AttributeTypecasting.disable_fallback_date_parsing!
  end

  def self.disable_non_iso_8601_datetime_attribute_parsing
    AttributeTypecasting.disable_fallback_datetime_parsing!
  end
end
