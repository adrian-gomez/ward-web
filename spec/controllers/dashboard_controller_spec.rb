require 'rails_helper'

RSpec.describe DashboardController do

  describe 'GET #index' do

    let!(:instance) { create(:instance) }

    it 'assigns all instances as @instances' do
      get :index

      expect(assigns(:instances)).to eq([instance])
    end

    it 'returns a success response' do
      get :index

      expect(response).to be_success
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end

  end

end