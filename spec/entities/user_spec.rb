require 'rails_helper'

RSpec.describe Entity::User do
  let(:valid_params) do
    {
      id: 1, first_name: 'Phil', last_name: 'Taylor', email: 'phil@taylor.com'
    }
  end

  context 'types' do
    context 'id' do
      it 'is required field' do
        valid_params.delete(:id)

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /:id is missing/)
        )
      end

      it 'accepts int' do
        user = Entity::User.new(valid_params)
        expect(user.id).to eq(1)
      end

      it 'does not accept non-int values' do
        valid_params[:id] = '10'

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /has invalid type for :id/)
        )
      end
    end

    context 'first_name' do
      it 'is required field' do
        valid_params.delete(:first_name)

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /:first_name is missing/)
        )
      end

      it 'accepts string' do
        user = Entity::User.new(valid_params)
        expect(user.first_name).to eq('Phil')
      end

      it 'does not accept non-string values' do
        valid_params[:first_name] = 10

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /has invalid type for :first_name/)
        )
      end
    end

    context 'last_name' do
      it 'is required field' do
        valid_params.delete(:last_name)

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /:last_name is missing/)
        )
      end

      it 'accepts string' do
        user = Entity::User.new(valid_params)
        expect(user.last_name).to eq('Taylor')
      end

      it 'does not accept non-string values' do
        valid_params[:last_name] = 10

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /has invalid type for :last_name/)
        )
      end
    end

    context 'email' do
      it 'is required field' do
        valid_params.delete(:email)

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /:email is missing/)
        )
      end

      it 'accepts string' do
        user = Entity::User.new(valid_params)
        expect(user.email).to eq('phil@taylor.com')
      end

      it 'does not accept non-string values' do
        valid_params[:email] = 10

        expect { Entity::User.new(valid_params) }.to(
          raise_error(Dry::Struct::Error, /has invalid type for :email/)
        )
      end
    end
  end
end
