require 'minitest/autorun'

class DateTest < Minitest::Test
  def test_iso_8601_format_is_enforced_on_date_dot_parse
    assert_raises(UnsafeDateParsing) do
      Date.parse('10/25/1999')
    end
  end

  def test_iso_8601_format_is_enforced_on_datetime_dot_parse
    assert_raises(UnsafeDateTimeParsing) do
      DateTime.parse('10/25/1999 11:00:00')
    end
  end

  def test_iso_8601_format_is_enforced_on_activerecord_date_columns
    assert_raises(InvalidDateFormat) do
      PatientUser.new(birth_date: '11/11/1999')
    end
  end

  def test_dateparser_raises_error_on_non_iso_8601_date_format
    assert_raises(DateParser::InvalidDateFormat) do
      DateParser.p('09/08/2001')
    end
  end

  def test_dateparser_accepts_iso_8601_date_format
    assert_equal Date.new(2011, 9, 8), DateParser.p('2011-09-08')
  end

  def test_datetimeparser_raises_error_on_non_iso_8601_datetime_format
    assert_raises(DateTimeParser::InvalidDateTimeFormat) do
      DateTimeParser.p('2011-01-01 06:30:00pm')
    end
  end

  def test_datetimeparser_accepts_iso_8601_datetime_format
    assert_equal DateTime.new(2011, 01, 10, 18, 30, 12), DateTimeParser.p('2011-01-10 18:30:12')
  end

  def test_datetimeparser_accepts_iso_8601_date_format_and_assumes_the_time_component_is_0
    assert_equal DateTime.new(2011, 01, 10, 00, 00, 00), DateTimeParser.p('2011-01-10')
  end
end
