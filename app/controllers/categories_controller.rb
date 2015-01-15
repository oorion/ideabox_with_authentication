class CategoriesController < ApplicationController
  def new
    # require 'pry'; binding.pry
    @user = User.find(session[:user_id])

    # authorize! :manage, @user
  end

  def create
    Category.create(name: params[:category][:name])
    redirect_to categories_path
  end

  def index
    @categories = Category.all
  end
end
