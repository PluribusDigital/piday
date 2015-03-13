class ResultsController < ApplicationController

  def create
    result = Result.new(params.require(:result).permit(:hits,:iterations))
    result.save
    render :json => {}
  end

  def totals
    render :json => {
      hits: Result.sum(:hits),
      iterations: Result.sum(:iterations)
    }
  end

end