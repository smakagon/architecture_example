require 'rails_helper'

RSpec.describe Repository::BaseRepository do
  context '#initialize' do
    it 'accepts data_source' do
      expect { described_class.new }.to(
        raise_error(ArgumentError, /missing keyword: data_source/)
      )
    end

    it 'adds attr_reader for data_source' do
      repository = described_class.new(data_source: 'Foo')
      expect(repository.data_source).to eq('Foo')
    end
  end

  context '.[]' do
    it 'instantiates repository with provided data source' do
      Repository::SpecUser = Class.new(Repository::BaseRepository)

      module DataSource
        module Spec
          class SpecUser; end
        end
      end

      expect(DataSource::Spec::SpecUser).to receive(:new)
      Repository::SpecUser[:spec]
    end
  end
end
