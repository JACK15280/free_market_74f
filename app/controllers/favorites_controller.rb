class FavoritesController < ApplicationController
  def create
    # binding.pry
    @user_id = current_user.id
    @product_id = Product.find(params[:id]).id
    @favorite = Favorite.new(product_id: @product_id, user_id: @user_id)

    if @favorite.save
      redirect_to user_path(current_user)
    else
      flash[:alert] = "保存できていません"
      redirect_to product_path(params[:id])
    end

  end

  def destroy
    @favorite = Favorite.find(params[:id])

    if @favorite.destroy
      redirect_to user_path(current_user)
    else
      flash[:alert] = "保存できていません"
      redirect_to product_path(params[:id])
    end

  end

end
