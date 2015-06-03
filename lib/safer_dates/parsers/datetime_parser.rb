require_relative '../utils/string_utils'

class DateTimeParser
  ISO_DATETIME = /\A(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)(\.\d+)?\z/

  def self.p(string)
    return nil if StringUtils.blank?(string)

    if string =~ ISO_DATETIME
      microsec = ($7.to_r * 1_000_000).to_i
      DateTime.new($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i, microsec)
    elsif string =~ DateParser::ISO_DATE
      DateTime.new($1.to_i, $2.to_i, $3.to_i, 00, 00, 00)
    else
      raise InvalidDateTimeFormat
    end
  end

  class InvalidDateTimeFormat < StandardError; end
end
