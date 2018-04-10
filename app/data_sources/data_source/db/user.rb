module DataSource
  module Db
    class User
      def all
        ::User.all.map { |user| user.attributes.symbolize_keys }
      end

      def create(params)
        ::User.create(params).attributes.symbolize_keys
      end
    end
  end
end
