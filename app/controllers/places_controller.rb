# frozen_string_literal: true

class PlacesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @places = Place.all.page(params[:page]).per(5)
  end

  def new
    @place = Place.new
  end

  def create
    current_user.places.create(place_params)
    redirect_to root_path
  end

  def show
    @place = Place.find(params[:id])
    end

    def edit
      @place = Place.find(params[:id])
    end

    def update
      @place = Place.find(params[:id])
      @place.update_attributes(place_params)
      redirect_to root_path
    end
    
    def destroy
      @place = Place.find(params[:id])
      @place.destroy
      redirect_to root_path
    end


  #warning everything under this is PRIVATE!!
  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

  

 
end

