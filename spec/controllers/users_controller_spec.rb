require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it 'assigns a new User to @user' do
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before { post :create, user: attributes_for(:user) }

      it 'saves the new user in the database' do
        expect { post :create, user: attributes_for(:user) }.
          to change(User, :count).by(1)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'assigns a success flash message' do
        expect(flash[:success]).not_to be_nil
      end
    end

    context 'with invalid attributes' do
      before { post :create, user: attributes_for(:invalid_user) }

      it 'does not save the user' do
        expect { post :create, user: attributes_for(:invalid_user) }.
          to_not change(User, :count)
      end

      it 're-renders new view' do
        expect(response).to render_template :new
      end

      it 'assigns an alert flash message' do
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
