require_relative '../utils/string_utils'
require_relative '../parsers/date_parser'

ActiveRecord::ConnectionAdapters::Column.class_eval do
  def self.fallback_string_to_date(string)
    return nil if StringUtils.blank?(string)
    raise InvalidDateFormat.new(string)
  end

  def self.fallback_string_to_time(string)
    return nil if StringUtils.blank?(string)

    if string =~ DateParser::ISO_DATE
      DateTime.new($1.to_i, $2.to_i, $3.to_i, 00, 00, 00)
    else
      raise InvalidDateTimeFormat.new(string)
    end
  end

  class InvalidDateFormat < StandardError; end
  class InvalidDateTimeFormat < StandardError; end
end
