require 'rails_helper'

RSpec.describe 'instances/edit' do

  let(:instance) { create(:instance) }

  before { assign(:instance, instance) }

  it 'renders the edit instance form' do
    render

    assert_select 'form[action=?][method=?]', instance_path(instance), 'post' do
      assert_select 'input[name=?][value=?]', '_method', 'patch'
      assert_select 'input[name=?]', 'instance[ip]'
      assert_select 'input[name=?]', 'instance[label]'

      assert_select 'input[type=?]', 'submit'
    end
  end

end