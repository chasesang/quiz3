class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction

  def new
    @bid = Bid.new bid_params
  end

  def create

      @bid = @auction.bids.new bid_params
      @bid.auction = @auction
      @bid.user = current_user

if cannot? :bid, @auction
  redirect_to auction_path(@auction), alert: 'You can not bid on your own product'

elsif @bid.price.present? && @bid.price <= @auction.current_price
  redirect_to auction_path(@auction), alert: ' You can not submit a bid lower than current price!'
elsif @bid.price.present? && @bid.price > @auction.current_price
    @bid.save
    if @bid.price >= @auction.reserve_price
    @auction.update({current_price: @bid.price})
    @auction.update({aasm_state: 'reserve_met'})
    redirect_to auction_path(@auction), notice: 'Bid submitted'
  else
    @auction.update({current_price: @bid.price})
    redirect_to auction_path(@auction), notice: 'Bid submitted'
  end

  else
      redirect_to auction_path(@auction), alert: @bid.errors.full_messages.join(', ')
end

end

  def edit
    @bid  = @auction.bids.find(params[:id])
  end

  def update
      @bid  = @auction.bids.find(params[:id])
      if @bid.update(bid_params)
      redirect_to auction_path(@auction), notice: 'Bid updated'
      else
      redirect_to auction_path(@auction), alert: @bid.errors.full_messages.join(', ')
    end
  end

  def destroy
      @bid  = @auction.bids.find(params[:id])
      if @bid.destroy
        redirect_to auction_path(@auction), notice: 'Bid delete!'
      end
    end



  private
  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def bid_params
  params.require(:bid).permit([:price])
  end

end
