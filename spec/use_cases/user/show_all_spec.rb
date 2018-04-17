require 'rails_helper'

RSpec.describe UseCase::User::ShowAll do
  let(:use_case) { described_class.new }

  context '#call' do
    context 'with success' do
      it 'broadcasts show_all_success event' do
        expect { use_case.call }.to broadcast(:show_all_success)
      end
    end

    context 'with error' do
      it 'broadcasts show_all_error event' do
        allow_any_instance_of(Repository::User).to(
          receive(:all).and_raise(ArgumentError)
        )

        expect { use_case.call }.to broadcast(:show_all_error)
      end
    end

    it 'calls #all on User Repository' do
      expect_any_instance_of(Repository::User).to receive(:all)
      use_case.call
    end
  end
end
