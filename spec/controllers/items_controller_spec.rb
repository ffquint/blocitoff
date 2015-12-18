require 'rails_helper'
include RandomData

RSpec.describe ItemsController, type: :controller do
  describe '#create' do
    let(:user) { create(:user) }

    context 'user signed in' do
      before { sign_in user }

      it "should have a user" do
        expect(user).to_not be_nil
      end

      #it "should get index" do
      #  get 'index'
      #  expect(response).to be_success
      #end

      it 'can create an item' do
        post :create, user_id: user.id, name: 'something'
        p response.status
         expect do

         end.to \
           change { Item.count }.by(1)

      end

      it 'redirects to user#show' do
        post :create, user_id: user.id, item: {name: 'something'}
        expect(response).to redirect_to user
      end

      it 'should belong to the user' do
        post :create, user_id: user.id, item: { name: 'something' }
        expect(assigns(:user_id)).to eq(user.id)
      end



      context 'blank item' do
        it 'displays an error' do
          post :create, user_id: user.id, item: {name: 'something'}
          expect(:item).not_to be_nil
        end
      end
    end

    context 'user not signed in' do
      it 'does not create an item' do
        post :create, user_id: user.id, item: {name: 'something'}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
