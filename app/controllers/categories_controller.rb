class CategoriesController < ApplicationController
  def new
    @user = User.find(current_user.id)
    authorize! :manage, @user
  end

  def create
    Category.create(name: params[:category][:name])
    redirect_to categories_path
  end

  def index
    @categories = Category.all
  end
end
