class UsersController < ApplicationController
  def index
    use_case = UseCase::User::ShowAll.new

    use_case.on(:show_all_success) { |users| return render json: { data: users } }
    use_case.on(:show_all_error) { |error| return render json: { error: error } }

    use_case.call
  end

  def create
    use_case = UseCase::User::CreateAccount.new

    use_case.on(:create_account_success) { |account| return render json: { data: account } }
    use_case.on(:create_account_error)   { |error| return render json: { error: error } }

    use_case.call(params.to_unsafe_h.slice(:first_name, :last_name, :email))
  end
end
