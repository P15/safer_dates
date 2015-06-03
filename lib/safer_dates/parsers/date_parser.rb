require_relative '../utils/string_utils'

class DateParser
  ISO_DATE = /\A(\d{4})-(\d\d)-(\d\d)\z/

  def self.p(string)
    return nil if StringUtils.blank?(string)

    if string =~ ISO_DATE
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise InvalidDateFormat
    end
  end

  class InvalidDateFormat < StandardError; end
end
