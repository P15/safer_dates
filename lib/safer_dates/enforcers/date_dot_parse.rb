module SaferDates
  module DateDotParse
    def self.disable!
      <<-eos
        Date.class_eval do
          def self.parse(input)
            raise UnsafeDateParsing.new(
              "\nDate.parse is not a reliable way to instantiate a date.\n" \
              "Prefer Date.new(yyyy, mm dd)\n"
            )
          end

          class UnsafeDateParsing < StandardError; end
        end
      eos
    end
  end
end
