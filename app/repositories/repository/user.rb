module Repository
  class User < BaseRepository
    def all
      wrap(data_source.all, Entity::User)
    end

    def create(params)
      wrap(data_source.create(params), Entity::User)
    end
  end
end
