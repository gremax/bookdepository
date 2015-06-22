require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }

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

  describe 'GET #edit' do
    before { get :edit, id: category }

    it 'assigns the requested category to @category' do
      expect(assigns(:category)).to eq category
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new category in the database' do
        expect { post :create, category: attributes_for(:category) }.
          to change(Category, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :create, category: attributes_for(:category)
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to show view' do
        post :create, category: attributes_for(:category)
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

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested category to @category' do
        patch :update, id: category, category: attributes_for(:category)
        expect(assigns(:category)).to eq category
      end

      it 'changes category attributes' do
        patch :update, id: category, category: { title: 'new title' }
        category.reload
        expect(category.title).to eq('new title')
      end

      it 'assigns a success flash message' do
        patch :update, id: category, category: attributes_for(:category)
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to the categories list' do
        patch :update, id: category, category: attributes_for(:category)
        expect(response).to redirect_to categories_path
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update, id: category, category: { title: '' }
      end

      it 'does not change category' do
        category.reload
        expect(category.title).to eq(category.title)
      end

      it 'assigns a danger flash message' do
        expect(flash[:danger]).not_to be_nil
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { category }

    it 'deletes category' do
      expect { delete :destroy, id: category }.to change(Category, :count).by(-1)
    end

    it 'assigns a warning flash message' do
      delete :destroy, id: category
      expect(flash[:warning]).not_to be_nil
    end

    it 'redirects to books' do
      delete :destroy, id: category
      expect(response).to redirect_to categories_path
    end
  end
end
