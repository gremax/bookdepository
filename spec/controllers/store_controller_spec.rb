require 'rails_helper'

RSpec.describe StoreController, type: :controller do
  describe 'GET #index' do
    let(:books) { create_list(:book, 2) }

    before { get :index }

    it 'fills an array of all books' do
      expect(assigns(:books)).to match_array(books)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
