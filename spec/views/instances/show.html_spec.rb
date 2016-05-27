require 'rails_helper'

RSpec.describe 'instances/show' do

  let(:instance) { create(:instance) }

  before { assign(:instance, instance) }

  it 'renders attributes in <p>' do
    render
  end

end