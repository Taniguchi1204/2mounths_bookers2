class UserGroupsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    join = current_user.user_groups.new(group_id: @group.id)
    join.save
    redirect_to request.referer
  end

  def destroy
    @group = Group.find(params[:group_id])
    join = current_user.user_groups.find_by(group_id: @group.id)
    join.destroy
    redirect_to request.referer
  end
end
