class CitiesController < ApplicationController
  include CitiesHelper
  include SessionsHelper
  require 'knn'
  require 'will_paginate/array'

  def index
  end

  def ranking
    @cities = City.all
    order_cities
    @cities = @cities.paginate(:page => params[:page], :per_page => 10)
    if params[:sort_cities]
      attr_to_erb
    end
  end

  def show_cities
    @citiesPaginated = City.paginate(:page => params[:page], :per_page => 12)

    if(params[:find])
      @find = params[:find]
      search_cities
      @cities = @cities.paginate(:page => params[:page], :per_page => 12)

      @cities.columns.each do |attr|
        if(params[:"from_#{attr.name}"].present?) && (params[:"to_#{attr.name}"].present?)
          @cities = @cities.where("#{attr.name}": params[:"from_#{attr.name}"].to_f .. params[:"to_#{attr.name}"].to_f)
          sorted = true
          break
        end
      end
      filter_cities
    else
      @cities = City.all.paginate(:page => params[:page], :per_page => 12)
      @cities = @cities.order(:name)
    end
  end


  def show
    @oldID = params[:id]
    if @oldID != nil
      @city = City.find(@oldID)
    end
    top3
  end

  def compare
    top3
    if(params[:id])
      @oldID = params[:id]
      @city1 = City.find(@oldID)
    end
    if(params[:newID])
      @newID = params[:newID]
      @city2 = City.find(@newID)
      @medals = Hash.new
      @medals = set_medals(@city1, @city2)
    end
    if(params[:find])
      search_cities
    else
      @cities = City.all.sort { |a,b| a.name.downcase <=> b.name.downcase }
    end
    @cities = @cities.paginate(:page => params[:page], :per_page => 12)

  end
end
