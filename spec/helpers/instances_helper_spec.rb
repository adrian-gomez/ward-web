require 'rails_helper'

RSpec.describe InstancesHelper do

  describe '#instance_title' do

    let(:instance) { create(:instance, ip: '127.1.1.4') }

    context 'when the instance has a label' do
      before { instance.label = 'some label' }

      it 'returns the label and the ip address of the instance' do
        expect(helper.instance_title(instance)).to eq('some label [127.1.1.4]')
      end
    end

    context 'when the instance does not have a label' do
      before { instance.label = '' }

      it 'returns the ip address of the instance' do
        expect(helper.instance_title(instance)).to eq('127.1.1.4')
      end
    end

  end

end