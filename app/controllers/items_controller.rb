class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:user_id]
      User.find_by_id!(params[:user_id])
      items = Item.all
      render json: items, include: :user
    else
    items = Item.all
    render json: items, include: :user
    end
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
    # have a user_id and all item information
  end

  def show
    item = Item.find_by!(id: params[:id])
    return render json: item
  end

  private
  
  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
  def not_found
    render json: { error: "User not found" }, status: :not_found
  end
end
