module Entity
  class User < Dry::Struct
    constructor_type :strict

    attribute :id, Types::Strict::Int
    attribute :first_name, Types::Strict::String
    attribute :last_name, Types::Strict::String
    attribute :email, Types::Strict::String
  end
end
