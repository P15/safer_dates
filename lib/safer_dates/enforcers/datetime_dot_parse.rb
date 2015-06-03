module SaferDates
  module DateTimeDotParse
    def self.disable!
      <<-eos
        DateTime.class_eval do
          def self.parse(input)
            raise UnsafeDateTimeParsing.new(
              "\nDateTime.parse is not a reliable way to instantiate a date.\n" \
              "Prefer DateTime.new(yyyy, mm, dd, hh, mm, ss)\n"
            )
          end

          class UnsafeDateTimeParsing < StandardError; end
        end
      eos
    end
  end
end
