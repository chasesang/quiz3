class AuctionsController < ApplicationController
before_action :authenticate_user!
before_action :find_auction, only: [:show, :edit, :update, :destroy]

  def new
    @auction = Auction.new
  end

  def create

    @auction = Auction.new auction_params
  
    if @auction.current_price == nil
      @auction.current_price == 1
    else
      @auction.current_price
    end
      @auction.user = current_user


    if @auction.save
      redirect_to auctions_path, notice: 'New Auction Created!'
    else

      render :new, alert: @auction.errors.full_messages.join(', ')
    end
  end


  def show

    @bids = @auction.bids
    @newbid = @auction.bids.new


  end


  def index
    @auctions = Auction.all.order("created_at DESC")
  end

  def edit
    if can? :edit, @auction
    else

    redirect_to auction_path(@auction), alert: 'access denied'
    end
  end

  def update
    if !(can? :edit, @auction)
    redirect_to auction_path(@auction), alert: 'access denied'

  elsif @auction.update(auction_params)
    redirect_to auctions_path, notice: 'Auction updated!'
  else
    render :edit, alert: 'Something went wrong!'
  end

end

  def destroy
    if can? :destroy, @auction
    @auction.destroy
    redirect_to auctions_path, notice:
    'Auction delete'
  else
    redirect_to auction_path(@auction), alert: 'access denied'
  end
  end




private

def find_auction
  @auction = Auction.find params[:id]
end

def auction_params
  params.require(:auction).permit([:title,:details, :end_date, :reserve_price, :current_price])
end

end
