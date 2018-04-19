require_relative 'dataset_generator'

module Evangelium
  class ModelGenerator
    def initialize(opts = {})
      @dataset_generator = Evangelium::DataSetGenerator.new opts
    end

    def model
      blueprint = {
          dataset: [
              {
                  type: 'dataset',
                  title: 'SDK Evangelium',
                  id: 'dataset.evangelium',
                  columns: []
              }
          ],
          date_dimensions: [],
          title: 'SDK Evangelium'
      }
      anchor = {
          type: 'anchor',
          id: 'attr.evangelium-policies.factsof',
          title: 'Records of Policies',
          description: nil,
          folder: nil
      }
      blueprint[:dataset].first[:columns] = [anchor] + columns + date_columns
      blueprint[:date_dimensions] = date_columns
      return blueprint
    end

    def date_columns
      headers = @dataset_generator.row.keys
      headers.select {|h| h[/date/]}.map do |id|
        {
            type: 'date',
            dataset: id
        }
      end
    end

    def columns
      headers = @dataset_generator.row.keys
      label_ids = headers.select {|h| h[/label/]}
      attributes = label_ids.map do |id|
        column = id_to_name id
        {
            type: 'attribute',
            id: 'attr.evangelium-policies.' + column,
            title: column.capitalize,
            description: nil,
            folder: 'SDK Evangelium'
        }
      end
      attr_labels = label_ids.map do |id|
        column = id_to_name id
        attribute = attributes.map {|a| a[:id]}.find {|a| a[/#{column}/]}
        {
            type: 'label',
            id: id,
            reference: attribute,
            title: column.capitalize,
            gd_data_type: 'VARCHAR(255)',
            gd_type: 'GDC.text',
            default_label: true
        }
      end
      facts = headers.select {|h| h[/fact/]}.map do |id|
        {
            type: 'fact',
            id: id,
            title: id_to_name(id).capitalize,
            folder: 'SDK Evangelium',
            gd_data_type: 'DECIMAL(15,6)',
        }
      end
      return attributes + attr_labels + facts
    end

    def id_to_name(id)
      return id.to_s.split('.').last
    end
  end
end