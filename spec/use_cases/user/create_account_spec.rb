require 'rails_helper'

RSpec.describe UseCase::User::CreateAccount do
  let(:use_case) { described_class.new }
  let(:valid_params) do
    { first_name: 'Phil', last_name: 'Taylor', email: 'phil@taylor.com' }
  end

  context '#call' do
    context 'with valid params' do
      it 'broadcasts create_account_success event' do
        expect { use_case.call(valid_params) }.to(
          broadcast(:create_account_success)
        )
      end
    end

    context 'with invalid params' do
      it 'broadcasts create_account_error event' do
        valid_params.delete(:first_name)
        expect { use_case.call(valid_params) }.to(
          broadcast(:create_account_error)
        )
      end
    end

    it 'calls #create on User Repository' do
      expect_any_instance_of(Repository::User).to receive(:create)
      use_case.call(valid_params)
    end

    context 'validation' do
      it 'validates presence of first name' do
        valid_params.delete(:first_name)

        expect { use_case.call(valid_params) }.to(
          broadcast(:create_account_error, /:first_name/)
        )
      end

      it 'validates presence of last name' do
        valid_params.delete(:last_name)

        expect { use_case.call(valid_params) }.to(
          broadcast(:create_account_error, /:last_name/)
        )
      end

      it 'validates format of email' do
        valid_params[:email] = 'nonemail'

        expect { use_case.call(valid_params) }.to(
          broadcast(:create_account_error, /invalid format/)
        )
      end
    end
  end
end
