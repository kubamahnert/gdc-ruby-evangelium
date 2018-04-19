require_relative '../lib/model_generator'
require 'json'

describe Evangelium::ModelGenerator do
  it 'works' do
    expect(subject.model)
    puts subject.model.to_json
  end
end