require 'rails_helper'

RSpec.describe Instances::ReadingsController do

  let!(:instance) { create(:instance) }

  describe 'GET #index' do

    let!(:reading) { create(:reading, instance: instance) }

    it 'returns a success response' do
      get :index, instance_id: instance.id

      expect(response).to be_success
    end

    it 'renders all readings of the instance' do
      get :index, instance_id: instance.id

      expect(response.body).to eq([reading].to_json)
    end

    context 'when an instance with the request ip does not exist' do
      it 'returns a not found response' do
        get :index, instance_id: 'non_existent'

        expect(response).to be_not_found
      end

      it 'returns an instance not found message' do
        get :index, instance_id: 'non_existent'

        expect(JSON(response.body)['messages']).to eq(['Instance not found'])
      end
    end

  end

end