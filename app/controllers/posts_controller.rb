class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    #上面2行也可以這樣
    #@post = current_user.posts.new(post_params)
    #@post.group_id = @group.id

    if @post.save
      redirect_to group_path(@group), notice: "新增留言成功！"
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "新增修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to group_path(@group), alert: "留言刪除成功！"
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
