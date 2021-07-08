class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    @group.save
    redirect_to groups_path
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end
end
