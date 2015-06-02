ActiveRecord::ConnectionAdapters::Column.class_eval do
  def self.fallback_string_to_date(string)
    raise InvalidDateFormat
  end

  def self.fallback_string_to_time(string)
    raise InvalidDateTimeFormat
  end

  class InvalidDateFormat < StandardError; end
  class InvalidDateTimeFormat < StandardError; end
end

Date.class_eval do
  def self.parse(input)
    raise UnsafeDateParsing.new(
      "\nDate.parse is not a reliable way to instantiate a date.\n" \
      "Prefer DateParse.p('yyyy-mm-dd')\n"
    )
  end

  class UnsafeDateParsing < StandardError; end
end

raise 'Already defined' if defined?(DateParse)

class DateParse
  ISO_DATE = /\A(\d{4})-(\d\d)-(\d\d)\z/

  def self.p(string)
    return nil if string.blank?

    if string =~ ISO_DATE
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise InvalidDateFormat
    end
  end

  class InvalidDateFormat < StandardError; end
end

raise 'Already defined' if defined?(DateParse)
class DateTimeParse
  ISO_DATETIME = /\A(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)(\.\d+)?\z/

  def self.p(string)
    return nil if string.blank?

    if string =~ ISO_DATETIME
      microsec = ($7.to_r * 1_000_000).to_i
      new_time($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i, microsec)
    else
      raise InvalidDateTimeFormat
    end
  end

  class InvalidDateTimeFormat < StandardError; end
end
