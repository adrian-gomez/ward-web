require 'rails_helper'

RSpec.describe 'instances/index' do

  let(:instances) { [create(:instance), create(:instance)] }

  before(:each) { assign(:instances, instances) }

  it 'renders a list of instances' do
    render
  end

end