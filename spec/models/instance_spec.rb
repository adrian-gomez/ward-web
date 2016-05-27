require 'rails_helper'

RSpec.describe Instance do

  describe 'validations' do

    let(:instance_attrs) { attributes_for(:instance) }

    context 'when the ip is empty' do
      before { instance_attrs[:ip] = '' }

      it 'adds an error for ip' do
        instance = Instance.create(instance_attrs)

        expect(instance.errors.keys).to eq([:ip])
      end
    end

    context 'when the ip is invalid' do
      before { instance_attrs[:ip] = 'invalid' }

      it 'adds an error for ip' do
        instance = Instance.create(instance_attrs)

        expect(instance.errors.keys).to eq([:ip])
      end
    end

  end

end