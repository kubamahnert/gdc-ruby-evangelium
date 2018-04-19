require 'faker'

require 'securerandom'

module Evangelium
  class DataSetGenerator
    def initialize(opts = {})
      @attr_columns = (opts[:attr_columns] || 3).times.map { [:name, :style, :hop, :yeast, :malts, :alcohol].sample }.map do |c|
        [c, SecureRandom.hex]
      end
      @date_columns = (opts[:date_columns] || 1).times.map { SecureRandom.hex }
      @fact_columns = (opts[:fact_columns] || 2).times.map { SecureRandom.hex }
    end

    def rows(number)
      array = []
      number.times do
        array << row
      end
      return array
    end

    def row
      labels.merge dates.merge facts
    end

    def labels
      @attr_columns.map do |a|
        ["label.evangelium-policies.#{a.first}-#{a.last}", Faker::Beer.send(a.first)]
      end.to_h
    end

    def dates
      @date_columns.map do |d|
        ["date.evangelium-policies.created_at-#{d}", Faker::Time.between(DateTime.now - 10, DateTime.now)]
      end.to_h
    end

    def facts
      @fact_columns.map do |f|
        ["fact.evangelium-policies.price-#{f}", Faker::Commerce.price]
      end.to_h
    end
  end
end