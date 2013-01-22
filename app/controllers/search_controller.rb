class SearchController < ApplicationController
  def index
  end

  def show
    if params[:query].present?
      @query = params[:query]
      @results = Product.basic_search(@query)
    end
  end
end
