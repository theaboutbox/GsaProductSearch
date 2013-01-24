class SearchController < ApplicationController
  def index
  end

  def show
    if params[:query].present?
      @query = params[:query]
      @results = Product.basic_search(@query).order('price_cents asc')
    end
  end
end
