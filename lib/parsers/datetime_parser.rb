# Raise an error rather than accidentally overwriting a class someone else has
# already defined
raise 'Already defined' if defined?(DateParse)

class DateTimeParser
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
