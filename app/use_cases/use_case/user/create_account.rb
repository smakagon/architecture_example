module UseCase
  module User
    class CreateAccount
      include Wisper::Publisher

      def call(params)
        validation = CreateAccountValidator.call(params)
        raise validation.errors.to_s unless validation.success?

        account = Repository::User[:db].create(params)

        broadcast(:create_account_success, account)
      rescue => e
        broadcast(:create_account_error, e.message)
      end
    end

    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    CreateAccountValidator = Dry::Validation.Schema do
      required(:first_name).filled
      required(:last_name).filled

      required(:email).filled(format?: EMAIL_REGEX)
    end
  end
end
