module UseCase
  module User
    class ShowAll
      include Wisper::Publisher

      def call
        broadcast(:show_all_success, Repository::User[:db].all)
      rescue
        broadcast(:show_all_error, 'Sorry, could not load all users')
      end
    end
  end
end
