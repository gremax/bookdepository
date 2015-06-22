require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin) { create(:admin) }

  before do
    sign_in(admin, no_capybara: true)
  end

  describe 'GET #index' do
    let(:categories) { create_list(:category, 2) }

    before { get :index }

    it 'fills an array of all categories' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Category to @category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new category in the database' do
        expect { post :create, category: { title: 'Fiction' } }.
          to change(Category, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :create, category: { title: 'Fiction' }
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to show view' do
        post :create, category: { title: 'Fiction' }
        expect(response).to redirect_to categories_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the category' do
        expect { post :create, category: { title: '' } }.
          to_not change(Category, :count)
      end

      it 'assigns a danger flash message' do
        post :create, category: { title: '' }
        expect(flash[:danger]).not_to be_nil
      end

      it 're-renders new view' do
        post :create, category: { title: '' }
        expect(response).to render_template :new
      end
    end
  end
end
