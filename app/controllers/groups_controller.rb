class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit, notice: "討論版更新成功"
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "討論版已刪除"
  end

  def join
    @group = Group.find(params[:id])

    if !@group.has_this_member?(current_user)
      current_user.join!(@group)
      flash[:notice] = "加入本討論版成功～"
    else
      flash[:warning] = "你已經是本討論版成員了"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if @group.has_this_member?(current_user)
      current_user.quit!(@group)
      flash[:alert] = "已退出本討論版"
    else
      flash[:warning] = "本非成員，如何退？"
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
