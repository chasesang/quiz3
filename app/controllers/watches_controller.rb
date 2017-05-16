class WatchesController < ApplicationController

before_action :authenticate_user!

def index
  user = User.find(params[:user_id])
  @auctions = user.watched_auctions
  render 'auctions/index'

end

    def create

      @auction = Auction.find(params[:auction_id])

      watch = Watch.new(user: current_user, auction: @auction)


      if watch.save
        redirect_to auction_path(@auction), notice: 'Auction watched!'

      else
        redirect_to auction_path(@auction), alert: watch.errors.full_messages.join(', ')

      end
    end

    def destroy
      @auction = Auction.find(params[:auction_id])
      watch = Watch.find(params[:id])

         if watch.destroy
           redirect_to auction_path(@auction), notice: 'Un-watchd auction!'
         else
        redirect_to auction_path(l@auction), alert: watch.errors.full_messages.join(', ')

         end
       end

end
