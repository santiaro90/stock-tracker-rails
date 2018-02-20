class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = 'No results found' unless @stock
    else
      flash.now[:danger] = 'The stock ticker is required'
    end

    render partial: 'stocks/lookup_results'
  end
end
