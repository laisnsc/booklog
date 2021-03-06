class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :update, :show, :destroy]
  before_action :get_user

  def index
    @lists = @user.lists
  end

  def new
    @list = @user.lists.build
  end

  def create
    @list = @user.lists.build(list_params)
    if @list.save
      redirect_to new_user_book_path(list: @list.id)
      flash[:success] = "New list created successfully"
    else
      render :new
      flash.now.alert = "Something went wrong. Please try again"
    end
  end

  def edit
  end

  def update
    updated = @list.update!(list_params)
    flash.now.alert = "Something went wrong. Please try again" unless updated
    redirect_to new_user_book_path(list: @list.id)
    flash[:success] = "List successfully edited!"
  end

  def show;end

  def destroy
    current_list = @list.destroy
    redirect_to user_lists_path(@user)
    if current_list.destroyed?
      flash[:success] = "List deleted successfully"
    else
      flash[:alert] = "Something went wrong. Please try again"
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :progress, :creation_date,
                                 :update_date)
  end

  def set_list
    @list = List.find(params[:id])
  end

  def get_user
    return @user = User.find(params[:user_id]) unless params[:user_id].nil?
    @user = @list.user
  end
end
