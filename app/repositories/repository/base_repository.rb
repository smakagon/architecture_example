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
      klass = self.to_s.split('::').last
      data_source_type = data_source_type.to_s.classify

      data_source = "DataSource::#{data_source_type}::#{klass}".constantize

      self.new(data_source: data_source.new)
    end

    def wrap(collection, entity_class)
      return [] if collection.blank?

      collection.map { |entity| entity_class.new(entity) }
    end
  end
end
