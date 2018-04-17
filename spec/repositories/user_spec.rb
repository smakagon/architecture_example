require 'rails_helper'

RSpec.describe Repository::User do
  let(:user_data) do
    # TODO: create factory
    { id: rand(100), first_name: 'Phil', last_name: 'Taylor', email: 'p@t.com' }
  end

  let(:data_source) do
    double('data_source', all: [user_data, user_data], create: user_data)
  end

  let(:repository) { described_class.new(data_source: data_source) }

  context '#all' do
    it 'delegates #all to data_source' do
      expect(data_source).to receive(:all)

      repository.all
    end

    it 'wraps collection of users data into entities' do
      expect(repository.all).to all(be_an(Entity::User))
    end
  end

  context '#create' do
    it 'delegates #create to data_source' do
      expect(data_source).to receive(:create)

      repository.create({})
    end

    it 'wraps response from data source into entity' do
      expect(repository.create(user_data)).to be_an(Entity::User)
    end
  end
end
