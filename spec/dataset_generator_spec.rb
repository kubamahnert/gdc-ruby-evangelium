require_relative '../lib/dataset_generator.rb'

describe Evangelium::DataSetGenerator do
  it 'generates a row' do
    expect(subject.row)
    puts subject.row
  end

  it 'generates many rows' do
    expect(a = subject.rows(5))
    puts subject.rows(5)
  end
end
