ActiveRecord::ConnectionAdapters::Column.class_eval do
  def self.fallback_string_to_date(string)
    return nil if StringUtils.blank?(string)
    raise InvalidDateFormat.new(string)
  end

  def self.fallback_string_to_time(string)
    return nil if StringUtils.blank?(string)
    raise InvalidDateTimeFormat.new(string)
  end

  class InvalidDateFormat < StandardError; end
  class InvalidDateTimeFormat < StandardError; end
end
