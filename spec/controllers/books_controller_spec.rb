require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }
  let(:admin) { create(:admin) }

  before do
    sign_in(admin, no_capybara: true)
  end

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

  describe 'GET #show' do
    before { get :show, id: book }

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq book
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Book to @book' do
      expect(assigns(:book)).to be_a_new(Book)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: book }

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq book
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new book in the database' do
        expect { post :create, book: attributes_for(:book) }.
          to change(Book, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, book: attributes_for(:book)
        expect(response).to redirect_to book_path(assigns(:book))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the book' do
        expect { post :create, book: attributes_for(:invalid_book) }.
          to_not change(Book, :count)
      end

      it 're-renders new view' do
        post :create, book: attributes_for(:invalid_book)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested book to @book' do
        patch :update, id: book, book: attributes_for(:book)
        expect(assigns(:book)).to eq book
      end

      it 'changes book attributes' do
        patch :update, id: book, book: { title: 'new title', price: 3.14 }
        book.reload
        expect(book.title).to eq('new title')
        expect(book.price).to eq(3.14)
      end

      it 'redirects to the updated book' do
        patch :update, id: book, book: attributes_for(:book)
        expect(response).to redirect_to book
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update, id: book, book: { title: 'new title', price: nil }
      end

      it 'does not change book attributes' do
        book.reload
        expect(book.title).to eq(book.title)
        expect(book.price).to eq(book.price)
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { book }

    it 'deletes book' do
      expect { delete :destroy, id: book }.to change(Book, :count).by(-1)
    end

    it 'redirects to books' do
      delete :destroy, id: book
      expect(response).to redirect_to books_path
    end
  end
end
