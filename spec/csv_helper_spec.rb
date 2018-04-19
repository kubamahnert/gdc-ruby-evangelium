require_relative '../lib/csv_helper'
require_relative '../lib/dataset_generator'

describe Evangelium::CsvHelper do
  it 'generates csv from row' do
    hash = Evangelium::DataGenerator.rows 5
    csv = subject.class.csv_from_hashes hash
    expect(csv)
  end
end