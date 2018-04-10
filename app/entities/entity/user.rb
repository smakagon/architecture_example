module Entity
  class User < Dry::Struct
    attribute :id, Types::Int
    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :email, Types::String
  end
end
