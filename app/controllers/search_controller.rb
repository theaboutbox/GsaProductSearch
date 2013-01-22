class SearchController < ApplicationController
  def index
    if params[:query].present?
      @query = params[:query]
      @results = Product.search(@query)
    end
  end
end
