module DataSource
  module InMemory
    class User
      def all
        [
          { id: 1, first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com' },
          { id: 2, first_name: 'Bar', last_name: 'Baz', email: 'bar@baz.com' }
        ]
      end

      def create(params)
        params.merge(id: rand(100))
      end
    end
  end
end
