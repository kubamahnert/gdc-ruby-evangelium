require 'csv'

module Evangelium
  class CsvHelper
    class << self
      def csv_from_hashes(hashes)
        temp_file = Tempfile.new('generated')

        CSV.open(temp_file, 'w', write_headers: true, headers: hashes.first.keys) do |csv|
          hashes.each {|hash| csv << hash}
        end
        return temp_file
      end
    end
  end
end