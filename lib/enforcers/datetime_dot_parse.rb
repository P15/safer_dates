DateTime.class_eval do
  def self.parse(input)
    raise UnsafeDateTimeParsing.new(
      "\nDateTime.parse is not a reliable way to instantiate a date.\n" \
      "Prefer DateTimeParser.p('yyyy-mm-dd')\n"
    )
  end

  class UnsafeDateTimeParsing < StandardError; end
end
