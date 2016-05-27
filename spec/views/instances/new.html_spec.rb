require 'rails_helper'

RSpec.describe 'instances/new' do

  let(:instance) { Instance.new }

  before { assign(:instance, instance) }

  it 'renders the new instance form' do
    render

    assert_select 'form[action=?][method=?]', instances_path, 'post' do
      assert_select 'input[name=?]', 'instance[ip]'
      assert_select 'input[name=?]', 'instance[label]'

      assert_select 'input[type=?]', 'submit'
    end
  end

end