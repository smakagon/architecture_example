module Repository
  class User < BaseRepository
    def all
      wrap(data_source.all, Entity::User)
    end

    def create(params)
      Entity::User.new(data_source.create(params))
    end
  end
end
