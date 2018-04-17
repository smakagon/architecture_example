module Repository
  class BaseRepository
    attr_reader :data_source

    def initialize(data_source:)
      @data_source = data_source
    end

    # Makes instantiation of repository with data source shorter.
    #
    # Instead of using long version:
    # Repository::User.new(data_source: DataSource::InMemory::User.new)
    #
    # You can instantiate repository using this approach:
    # Repository::User[:in_memory]
    def self.[](data_source_type)
      klass = to_s.split('::').last
      data_source_type = data_source_type.to_s.classify

      data_source = "DataSource::#{data_source_type}::#{klass}".constantize

      new(data_source: data_source.new)
    end

    def wrap(data, entity_class)
      return [] if data.blank?

      if data.is_a?(Array)
        data.map { |entity| wrap_entity(entity, entity_class) }
      else
        wrap_entity(data, entity_class)
      end
    end

    private

    def wrap_entity(entity_attributes, entity_class)
      entity_class.new(entity_attributes.slice(*entity_class.schema.keys))
    end
  end
end
