require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
    let(:auction) { FactoryGirl.create(:auction, {user: user})}
    

    describe '#new' do
      context 'with no user signed in' do
        it 'redirects the user to the home page' do
          get :new
          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'with user signed in' do
        before do
          request.session[:user_id] = user.id
        end

        it 'renders the new template' do

          get :new

          expect(response).to render_template(:new)
        end

        it 'assigns a new Auction instance variable' do

        get :new

        expect(assigns(:auction)).to be_a_new(Auction)
      end
      end
    end

    describe '#create' do
      context 'with no user signed in' do
        it 'redirects the user to the home page' do
          post :create
          expect(response).to redirect_to(new_session_path)
        end
      end
      context "with signed in user" do

        before { request.session[:user_id] = user.id }

        def valid_request
          post :create, params: {
                          auction: FactoryGirl.attributes_for(:auction)
                        }
        end

        it 'creates a new auction in the database' do
          count_before = Auction.count
          valid_request
          count_after = Auction.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirects to the auctions index page' do
          valid_request
          expect(response).to redirect_to(auctions_path)
        end

        it 'associates the created auction with the sigend in user' do

          valid_request

          expect(Auction.last.user).to eq(user)
          end

        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end
      end
    end


    describe '#edit' do
       context 'with no user signed in' do
         it 'redirects to the home page' do
           get :edit, params: { id: auction.id }
           expect(response).to redirect_to(new_session_path)
         end
       end
       context 'with user signed in' do
         before { request.session[:user_id] = user.id }


           it 'renders the edit template' do
             get :edit, params: { id: auction.id }
             expect(response).to render_template(:edit)
           end

           it 'sets an instance variable to the auction whose id was passed' do
            get :edit, params: { id: auction.id }

            expect(assigns(:auction)).to eq(auction)
          end
        end


   end

   describe '#destroy' do
     context 'with no signed in user' do
       it 'redirects to the home page' do
         delete :destroy, params: { id: auction.id }
         expect(response).to redirect_to(new_session_path)
     end
   end
     context 'with signed in user' do
       before { request.session[:user_id] = user.id }

         it 'removes the auction record from the database' do
           auction # we call auction here to force creating the auction before
                    # making the `delete :destroy` call
           count_before = Auction.count
           delete :destroy, params: { id: auction.id }
           count_after  = Auction.count
           expect(count_after).to eq(count_before - 1)
         end


   end
 end
 end
