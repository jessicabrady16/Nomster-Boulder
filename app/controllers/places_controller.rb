# frozen_string_literal: true

class PlacesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit destroy update]

  def index
    @places = Place.all.page(params[:page]).per(5).order("name")
  end

  def new
    @place = Place.new
  end

  def create
      @place =current_user.places.create(place_params)
      if @place.valid?
    redirect_to place_path(@place)
      else
        render :new, status: :unprocessable_entity
      end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new

    end

    def edit
      @place = Place.find(params[:id])

      if @place.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
    end
  end

    def update
      @place = Place.find(params[:id])
      if @place.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
    end
    @place.update_attributes(place_params)
     if @place.valid?
      redirect_to place_path(@place)
     else render :new, status: :unprocessable_entity
              end
            end

    def destroy
      @place = Place.find(params[:id])
      if @place.user != current_user
        return render plain: 'Not Allowed', status: :forbidden
    end
      @place.destroy
      redirect_to root_path

    end

   #warning everything under this is PRIVATE!!
  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end




end

