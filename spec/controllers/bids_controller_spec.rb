require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
    let(:auction) { FactoryGirl.create(:auction)}
    let(:bid) { FactoryGirl.create(:bid, {auction: auction})}


    describe '#create' do

      context "with signed in user" do

        before do
        request.session[:user_id] = user.id

      end

        def valid_request
          post :create, params: {
            auction_id: auction.id,
            bid: FactoryGirl.attributes_for(:bid)
                        }
        end

        it 'creates a new bid in the database' do

          count_before = Bid.count
          valid_request
          count_after = Bid.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirects to the auctions show page' do
          valid_request
          expect(response).to redirect_to(auction_path(Bid.last))
        end

        it 'associates the created auction with the sigend in user' do

          valid_request

          expect(Bid.last.user).to eq(user)
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
           get :edit, params: {
             auction_id: auction.id,
             bid: FactoryGirl.attributes_for(:bid)
                         }
           expect(response).to redirect_to(new_session_path)
         end
       end
       context 'with user signed in' do
         before { request.session[:user_id] = user.id }


           it 'renders the edit template' do
             get :edit, params: {
               auction_id: auction.id,
               bid: FactoryGirl.attributes_for(:bid)
                           }
             expect(response).to render_template(:edit)
           end

           it 'sets an instance variable to the auction whose id was passed' do
            get :edit, params: {
              auction_id: auction.id,
              bid: FactoryGirl.attributes_for(:bid)
                          }

            expect(assigns(:bid)).to eq(bid)
          end
        end


   end

   describe '#destroy' do

     context 'with signed in user' do
       before { request.session[:user_id] = user.id }

         it 'removes the auction record from the database' do
           bid
           count_before = Bid.count
           delete :destroy, params: {
             auction_id: auction.id,
             id: bid.id
                         }
           count_after  = Bid.count
           expect(count_after).to eq(count_before - 1)
         end


   end
  end
  end
