class AuctionsController < ApplicationController

  def index
    @auctions = Auction.get_active_auctions
  end

  def new 
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      redirect_to @auction 
    else 
      flash[:error] = @auction.errors.full_messages
      redirect_to auctions_path
    end
  end

  def show 
    @auction = Auction.find(params[:id])
  end

  def edit
    @auction = Auction.find(params[:id])
  end

  def update
    @auction = Auction.find(params[:id])
    @auction.update(auction_params)
     if @auction.save
      redirect_to @auction
    else 
      flash[:error] = @auction.errors.full_messages
      render :edit   
    end
  end

  def destroy 
    @auction = Auction.find(params[:id])
    if @auction.destroy
      redirect_to auctions_path
    else 
      render :edit 
    end  
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :description, :end_time)
  end


end
