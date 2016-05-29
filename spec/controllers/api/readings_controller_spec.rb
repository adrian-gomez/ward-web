require 'rails_helper'

RSpec.describe Api::ReadingsController do

  let!(:instance) { create(:instance) }

  describe 'POST #create' do

    before { request.env['REMOTE_ADDR'] = instance.ip }

    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:reading) }

      it 'creates a new instance reading' do
        expect {
          post :create, { reading: valid_attributes }
        }.to change(instance.readings, :count).by(1)
      end

      it 'returns a success response' do
        post :create, { reading: valid_attributes }

        expect(response).to be_success
      end

      it 'returns a success message' do
        post :create, { reading: valid_attributes }

        expect(JSON(response.body)['messages']).to eq(['Reading stored'])
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:reading).merge(data: {}) }

      it 'does not create a new instance reading' do
        expect {
          post :create, { reading: invalid_attributes }
        }.to_not change(instance.readings, :count)
      end

      it 'returns an unprocessable entity response' do
        post :create

        expect(response).to be_unprocessable
      end

      it 'returns an error message' do
        post :create, { reading: invalid_attributes }

        expect(JSON(response.body)['messages']).to eq(['Data can\'t be blank'])
      end
    end

    context 'when reading is not given' do
      it 'returns an unprocessable entity response' do
        post :create

        expect(response).to be_unprocessable
      end

      it 'returns an reading parameter required message' do
        post :create

        expect(JSON(response.body)['messages']).to eq(['Parameter reading is required'])
      end
    end

    context 'when an instance with the request ip does not exist' do
      before { request.env['REMOTE_ADDR'] = '1.2.3.4' }

      it 'returns a not found response' do
        post :create, { reading: {} }

        expect(response).to be_not_found
      end

      it 'returns an instance not found message' do
        post :create, { reading: {} }

        expect(JSON(response.body)['messages']).to eq(['Instance not registered'])
      end
    end

  end

end