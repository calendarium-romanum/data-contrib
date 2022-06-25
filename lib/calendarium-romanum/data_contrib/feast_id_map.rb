require 'csv'

module CalendariumRomanum
  module DataContrib
    # Wraps a CSV spreadsheet mapping several feast ID systems,
    # provides Hashes translating between any two of the systems
    class FeastIdMap
      DEFAULT_PATH = File.expand_path '../../../interop/feast_ids.csv', __dir__

      # columns of the CSV containing feast IDs
      COLUMNS = %i(calendarium_romanum cantus romcal)

      # loads the default CSV
      def self.load_default
        File.open(DEFAULT_PATH) {|f| parse_csv f }
      end

      def self.parse_csv(input)
        parse_options = {
          headers: true,
          header_converters: :symbol,
          # load calendarium-romanum celebration symbols as Symbols
          converters: proc do |field, field_info|
            field_info.header == :calendarium_romanum ? field.to_sym : field
          end
        }
        new CSV.parse(input, **parse_options)
      end

      def initialize(data)
        @data = data
      end

      # For each pair of feast ID systems we define a method
      # which builds the translation Hash
      #
      # @!method calendarium_romanum_to_cantus
      #   @return [Hash<Symbol => String>]
      # @!method cantus_to_calendarium_romanum
      #   @return [Hash<String => Symbol>]
      # @!method cantus_to_romcal
      #   @return [Hash<String => String>]
      # ... ...
      COLUMNS
        .product(COLUMNS)
        .reject {|a, b| a == b }
        .each do |a, b|
        define_method "#{a}_to_#{b}" do
          r = {}
          @data.each do |row|
            next if row[b].nil?
            r[row[a]] = row[b]
          end
          r
        end
      end
    end
  end
end
