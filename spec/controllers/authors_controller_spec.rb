require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:admin) { create(:admin) }

  before do
    sign_in(admin, no_capybara: true)
  end

  describe 'GET #index' do
    let(:authors) { create_list(:author, 2) }

    before { get :index }

    it 'fills an array of all authors' do
      expect(assigns(:authors)).to match_array(authors)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Author to @author' do
      expect(assigns(:author)).to be_a_new(Author)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new author in the database' do
        expect { post :create, author: attributes_for(:author) }.
          to change(Author, :count).by(1)
      end

      it 'assigns a success flash message' do
        post :create, author: attributes_for(:author)
        expect(flash[:success]).not_to be_nil
      end

      it 'redirects to show view' do
        post :create, author: attributes_for(:author)
        expect(response).to redirect_to authors_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the author' do
        expect { post :create, author: attributes_for(:invalid_author) }.
          to_not change(Author, :count)
      end

      it 'assigns a danger flash message' do
        post :create, author: attributes_for(:invalid_author)
        expect(flash[:danger]).not_to be_nil
      end

      it 're-renders new view' do
        post :create, author: attributes_for(:invalid_author)
        expect(response).to render_template :new
      end
    end
  end
end
