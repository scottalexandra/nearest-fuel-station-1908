class SearchController < ApplicationController
  def index
    render locals: {
      station: SearchResults.new(params[:location]).stations
    }
  end
end
