require 'rails_helper'

RSpec.describe ReportsController do

  describe 'GET #index' do

    let!(:instance) { create(:instance) }

    it 'assigns the cpu usage rank as @cpu_usage_rank' do
      get :index

      expect(assigns(:cpu_usage_rank)).to be
    end

    it 'assigns the instances with log disk space as @low_disk_space' do
      get :index

      expect(assigns(:low_disk_space)).to be
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