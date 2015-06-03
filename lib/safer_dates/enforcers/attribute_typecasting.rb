ActiveRecord::ConnectionAdapters::Column.class_eval do
  def self.fallback_string_to_date(string)
    raise InvalidDateFormat.new(string)
  end

  def self.fallback_string_to_time(string)
    raise InvalidDateTimeFormat.new(string)
  end

  class InvalidDateFormat < StandardError; end
  class InvalidDateTimeFormat < StandardError; end
end
