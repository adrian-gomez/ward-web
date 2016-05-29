require 'rails_helper'

RSpec.describe Reading do

  describe 'validations' do

    let(:instance)      { create(:instance) }
    let(:reading_attrs) { attributes_for(:reading).merge(instance: instance) }

    context 'when data is empty' do
      before { reading_attrs[:data] = {} }

      it 'adds an error for data' do
        reading = Reading.create(reading_attrs)

        expect(reading.errors.keys).to eq([:data])
      end
    end

  end

end