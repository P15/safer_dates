Date.class_eval do
  def self.parse(input)
    raise UnsafeDateParsing.new(
      "\nDate.parse is not a reliable way to instantiate a date.\n" \
      "Prefer DateParser.p('yyyy-mm-dd')\n"
    )
  end

  class UnsafeDateParsing < StandardError; end
end
