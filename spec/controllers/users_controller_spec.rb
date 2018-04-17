require 'rails_helper'
require 'wisper/rspec/stub_wisper_publisher'

RSpec.describe UsersController, type: :request do
  context 'GET #index' do
    it 'executes #call on ShowAll use case' do
      expect_any_instance_of(UseCase::User::ShowAll).to receive(:call)

      get users_path
    end

    it 'renders data for successful call' do
      get users_path
      expect(response.body).to include('data')
    end

    it 'renders error for unsuccessful call' do
      stub_wisper_publisher(
        'UseCase::User::ShowAll', :call, :show_all_error, 'Use Case Error'
      )

      get users_path
      expect(response.body).to include('Use Case Error')
    end
  end

  context 'POST #create' do
    it 'execute #call on CreateAccount use case' do
      expect_any_instance_of(UseCase::User::CreateAccount).to receive(:call)

      post users_path
    end

    it 'renders data for successful call' do
      user_attrs = { first_name: 'Phil', last_name: 'Taylor', email: 'p@t.com' }
      post users_path, params: user_attrs

      expect(response.body).to include('data')
    end

    it 'renders error for unsuccessful call' do
      post users_path
      expect(response.body).to include('error')
    end
  end
end
