require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:order_items) { create_list(:order_item, 2) }

    before do
      sign_in(user, no_capybara: true)
      get :show
    end

    xit 'fills an array of all books' do
      expect(assigns(:order_items)).to match_array(order_items)
    end

    xit 'renders index view' do
      expect(response).to render_template :show
    end
  end
end
