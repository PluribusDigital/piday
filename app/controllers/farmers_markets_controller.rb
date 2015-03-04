class FarmersMarketsController < ApplicationController

  def index
    if params[:zip]
      @markets = FarmersMarketDirectoryService.new.zip_search params[:zip]
    elsif params[:lat] && params[:long]
      @markets = FarmersMarketDirectoryService.new.lat_long_search params[:lat], params[:long]
    else 
      @markets = []
    end
    render :json => @markets
  end

  def show
    @market = FarmersMarketDirectoryService.new.market_detail params[:id]
    render :json => @market
  end

end