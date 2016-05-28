require 'rails_helper'

RSpec.describe Reading do

  describe 'validations' do

    let(:instance)      { create(:instance) }
    let(:reading_attrs) { attributes_for(:reading).merge(instance: instance) }

    context 'when type is empty' do
      before { reading_attrs[:type] = '' }

      it 'adds an error for type' do
        reading = Reading.create(reading_attrs)

        expect(reading.errors.keys).to eq([:type])
      end
    end

    context 'when type is invalid' do
      before { reading_attrs[:type] = 'invalid' }

      it 'adds an error for type' do
        reading = Reading.create(reading_attrs)

        expect(reading.errors.keys).to eq([:type])
      end
    end

    context 'when value is empty' do
      before { reading_attrs[:value] = '' }

      it 'adds an error for value' do
        reading = Reading.create(reading_attrs)

        expect(reading.errors.keys).to eq([:value])
      end
    end

  end

end