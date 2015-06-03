# Suggested tests to put in a Rails app

require_relative '../test_helper'

class DateTest < ActiveSupport::TestCase
  test 'ISO 8601 format is enforced on Date.parse' do
    assert_raises(UnsafeDateParsing) do
      Date.parse('10/25/1999')
    end
  end

  test 'ISO 8601 format is enforced on DateTime.parse' do
    assert_raises(UnsafeDateTimeParsing) do
      DateTime.parse('10/25/1999 11:00:00')
    end
  end

  test 'ISO 8601 format is enforced on ActiveRecord date columns' do
    assert_raises(InvalidDateFormat) do
      PatientUser.new(birth_date: '11/11/1999')
    end
  end

  test 'ActiveRecord date columns accept blank strings as nil dates' do
    assert_equal nil, PatientUser.new(birth_date: '').birth_date
    assert_equal nil, PatientUser.new(birth_date: '   ').birth_date
    assert_equal nil, PatientUser.new(birth_date: "   \n\t\r  ").birth_date
  end

  test 'ActiveRecord date columns accept nil object' do
    assert_equal nil, PatientUser.new(birth_date: nil).birth_date
  end

  test 'ActiveRecord date columns accept date object' do
    assert_equal Date.new(1999, 12, 31), PatientUser.new(birth_date: Date.new(1999, 12, 31)).birth_date
  end

  test 'ISO 8601 format is enforced on ActiveRecord datetime columns' do
    assert_raises(InvalidDateTimeFormat) do
      PatientUser.new(created_at: '11/11/1999')
    end
  end

  test 'ActiveRecord datetime columns accept blank strings as nil datetimes' do
    assert_equal nil, PatientUser.new(created_at: '').created_at
    assert_equal nil, PatientUser.new(created_at: '   ').created_at
    assert_equal nil, PatientUser.new(created_at: "   \n\t\r  ").created_at
  end

  test 'ActiveRecord datetime columns accept ISO 8601 date string as a date with 00:00 time component' do
    expected = DateTime.new(2030, 12, 25, 00, 00, 00, '-5')
    actual = PatientUser.new(created_at: '2030-12-25').created_at
    assert_equal expected, actual
  end

  test 'ActiveRecord datetime columns accept nil object' do
    assert_equal nil, PatientUser.new(created_at: nil).created_at
  end

  test 'ActiveRecord datetime columns accept datetime object' do
    expected = DateTime.new(1999, 12, 31, 12, 30, 50)
    actual = PatientUser.new(created_at: DateTime.new(1999, 12, 31, 12, 30, 50)).created_at
    assert_equal expected, actual
  end

  test 'DateParser raises error on non-ISO 8601 date format' do
    assert_raises(DateParser::InvalidDateFormat) do
      DateParser.p('09/08/2001')
    end
  end

  test 'DateParser accepts ISO 8601 date format' do
    assert_equal Date.new(2011, 9, 8), DateParser.p('2011-09-08')
  end

  test 'DateTimeParser raises error on non-ISO 8601 datetime format' do
    assert_raises(DateTimeParser::InvalidDateTimeFormat) do
      DateTimeParser.p('2011-01-01 06:30:00pm')
    end
  end

  test 'DateTimeParser accepts ISO 8601 datetime format' do
    assert_equal DateTime.new(2011, 01, 10, 18, 30, 12), DateTimeParser.p('2011-01-10 18:30:12')
  end

  test 'DateTimeParser accepts ISO 8601 *date* format and assumes the time component is 0' do
    assert_equal DateTime.new(2011, 01, 10, 00, 00, 00), DateTimeParser.p('2011-01-10')
  end
end
