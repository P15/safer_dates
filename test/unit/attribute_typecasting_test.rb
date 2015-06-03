require 'minitest/autorun'
require 'safer_dates/enforcers/attribute_typecasting'

class AttributeTypecastingTest < Minitest::Test
  class PatientUser < ActiveRecord::Base
  end

  def test_activerecord_date_columns_accept_blank_strings_as_nil_dates
    assert_equal nil, PatientUser.new(birth_date: '').birth_date
    assert_equal nil, PatientUser.new(birth_date: '   ').birth_date
    assert_equal nil, PatientUser.new(birth_date: "   \n\t\r  ").birth_date
  end

  def test_activerecord_date_columns_accept_nil_object
    assert_equal nil, PatientUser.new(birth_date: nil).birth_date
  end

  def test_activerecord_date_columns_accept_date_object
    assert_equal Date.new(1999, 12, 31), PatientUser.new(birth_date: Date.new(1999, 12, 31)).birth_date
  end

  def test_iso_8601_format_is_enforced_on_activerecord_datetime_columns
    assert_raises(InvalidDateTimeFormat) do
      PatientUser.new(created_at: '11/11/1999')
    end
  end

  def test_activerecord_datetime_columns_accept_blank_strings_as_nil_datetimes
    assert_equal nil, PatientUser.new(created_at: '').created_at
    assert_equal nil, PatientUser.new(created_at: '   ').created_at
    assert_equal nil, PatientUser.new(created_at: "   \n\t\r  ").created_at
  end

  def test_activerecord_datetime_columns_accept_iso_8601_date_string_as_a_date_with_00_time_component
    expected = DateTime.new(2030, 12, 25, 00, 00, 00, '-5')
    actual = PatientUser.new(created_at: '2030-12-25').created_at
    assert_equal expected, actual
  end

  def test_activerecord_datetime_columns_accept_nil_object
    assert_equal nil, PatientUser.new(created_at: nil).created_at
  end

  def test_activerecord_datetime_columns_accept_datetime_object
    expected = DateTime.new(1999, 12, 31, 12, 30, 50)
    actual = PatientUser.new(created_at: DateTime.new(1999, 12, 31, 12, 30, 50)).created_at
    assert_equal expected, actual
  end
end
