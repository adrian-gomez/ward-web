require 'rails_helper'

RSpec.describe InstancesController do

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

  describe 'GET #show' do

    let!(:instance) { create(:instance) }

    it 'assigns the requested instance as @instance' do
      get :show, { id: instance.id }

      expect(assigns(:instance)).to eq(instance)
    end

    it 'returns a success response' do
      get :show, { id: instance.id }

      expect(response).to be_success
    end

    it 'renders the show template' do
      get :show, { id: instance.id }

      expect(response).to render_template(:show)
    end

    context 'when the instance does not exist' do
      it 'redirects to the instances list' do
        get :show, { id: 'non_existent' }

        expect(response).to redirect_to(instances_url)
      end

      it 'sets an alert message' do
        get :show, { id: 'non_existent' }

        expect(flash[:alert]).to eq('Instance not found.')
      end
    end

  end

  describe 'GET #new' do

    it 'assigns a new instance as @instance' do
      get :new

      expect(assigns(:instance)).to be_a_new(Instance)
    end

    it 'returns a success response' do
      get :new

      expect(response).to be_success
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end

  end

  describe 'GET #edit' do

    let!(:instance) { create(:instance) }

    it 'assigns the requested instance as @instance' do
      get :edit, { id: instance.id }

      expect(assigns(:instance)).to eq(instance)
    end

    it 'returns a success response' do
      get :edit, { id: instance.id }

      expect(response).to be_success
    end

    it 'renders the edit template' do
      get :edit, { id: instance.id }

      expect(response).to render_template(:edit)
    end

    context 'when the instance does not exist' do
      it 'redirects to the instances list' do
        get :edit, { id: 'non_existent' }

        expect(response).to redirect_to(instances_url)
      end

      it 'sets an alert message' do
        get :edit, { id: 'non_existent' }

        expect(flash[:alert]).to eq('Instance not found.')
      end
    end

  end

  describe 'POST #create' do

    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:instance) }

      it 'creates a new Instance' do
        expect {
          post :create, { instance: valid_attributes }
        }.to change(Instance, :count).by(1)
      end

      it 'redirects to the created instance' do
        post :create, { instance: valid_attributes }

        expect(response).to redirect_to(Instance.last)
      end

      it 'sets a notice message' do
        post :create, { instance: valid_attributes }

        expect(flash[:notice]).to eq('Instance was successfully created.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:instance).merge(ip: 'invalid') }

      it 'does not create a new Instance' do
        expect {
          post :create, { instance: invalid_attributes }
        }.to_not change(Instance, :count)
      end

      it 'returns a success response' do
        post :create, { instance: invalid_attributes }

        expect(response).to be_success
      end

      it 'assigns a newly created but unsaved instance as @instance' do
        post :create, { instance: invalid_attributes }

        expect(assigns(:instance)).to be_a_new(Instance)
      end

      it 'renders the new template' do
        post :create, { instance: invalid_attributes }

        expect(response).to render_template(:new)
      end
    end

  end

  describe 'PUT #update' do

    let!(:instance) { create(:instance) }

    context 'with valid params' do
      let(:new_attributes) { { label: 'new label' } }

      it 'updates the requested instance' do
        expect {
          put :update, { instance: new_attributes }.merge(id: instance.id).merge(id: instance.id)

          instance.reload
        }.to change(instance, :label).from(instance.label).to('new label')
      end

      it 'assigns the requested instance as @instance' do
        put :update, { instance: new_attributes }.merge(id: instance.id)

        expect(assigns(:instance)).to eq(instance)
      end

      it 'redirects to the instance' do
        put :update, { instance: new_attributes }.merge(id: instance.id)

        expect(response).to redirect_to(instance)
      end

      it 'sets a notice message' do
        put :update, { instance: new_attributes }.merge(id: instance.id)

        expect(flash[:notice]).to eq('Instance was successfully updated.')
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { ip: 'invalid' } }

      it 'assigns the instance as @instance' do
        put :update, { instance: invalid_attributes }.merge(id: instance.id)

        expect(assigns(:instance)).to eq(instance)
      end

      it 'returns a success response' do
        put :update, { instance: invalid_attributes }.merge(id: instance.id)

        expect(response).to be_success
      end

      it 'renders the edit template' do
        put :update, { instance: invalid_attributes }.merge(id: instance.id)

        expect(response).to render_template(:edit)
      end
    end

    context 'when the instance does not exist' do
      it 'redirects to the instances list' do
        put :update, { id: 'non_existent' }

        expect(response).to redirect_to(instances_url)
      end

      it 'sets an alert message' do
        put :update, { id: 'non_existent' }

        expect(flash[:alert]).to eq('Instance not found.')
      end
    end

  end

  describe 'DELETE #destroy' do

    let!(:instance) { create(:instance) }

    it 'destroys the requested instance' do
      expect {
        delete :destroy, { id: instance.id }
      }.to change { Instance.where(id: instance.id).exists? }.from(true).to(false)
    end

    it 'redirects to the instances list' do
      delete :destroy, { id: instance.id }

      expect(response).to redirect_to(instances_url)
    end

    it 'sets a notice message' do
      delete :destroy, { id: instance.id }

      expect(flash[:notice]).to eq('Instance was successfully destroyed.')
    end

    context 'when the instance does not exist' do
      it 'redirects to the instances list' do
        delete :destroy, { id: 'non_existent' }

        expect(response).to redirect_to(instances_url)
      end

      it 'sets an alert message' do
        delete :destroy, { id: 'non_existent' }

        expect(flash[:alert]).to eq('Instance not found.')
      end
    end

  end

end