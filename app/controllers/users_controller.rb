# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_5_star = @user.comments.where(rating: '5_stars').count
    @comment_count = @user.comments.count
  end
end
