class UsersController < ApplicationController
  def index
    use_case = UseCase::User::ShowAll.new

    use_case.on(:show_all_success) do |users|
      return render json: { data: users }
    end

    use_case.on(:show_all_error) do |error|
      return render json: { error: error }
    end

    use_case.call
  end

  def create
    use_case = UseCase::User::CreateAccount.new

    use_case.on(:create_account_success) do |account|
      return render json: { data: account }
    end

    use_case.on(:create_account_error) do |error|
      return render json: { error: error }
    end

    use_case.call(
      params.to_unsafe_h.slice(:first_name, :last_name, :email).symbolize_keys
    )
  end
end
