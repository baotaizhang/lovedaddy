class BoardPostsController < ApplicationController
  # TODO: ログインしていなくても見れる範囲の確認
  before_action :set_board_post,  only: [:show]
  before_action :set_my_board_post, only: [:edit, :update, :destroy]

  def index
    authorize! :index, BoardPost
    other_sex = current_user.sex.male? ? :female : :male
    @q = BoardPost.left_joins(:user).where(users: {sex: other_sex}).search(params[:q])
    @board_posts = @q.result(distinct: true).includes(user: [:user_options]).where(users: {deleted_at: nil}).order(created_at: :desc).page(params[:page]).decorate
  end

  def history
    authorize! :index, BoardPost
    @board_posts = current_user.board_posts.all.order('created_at DESC').decorate
  end

  def show
    authorize! :show, BoardPost
  end

  def new
    authorize! :create, BoardPost
    @board_post = BoardPost.new
  end

  def edit
    authorize! :manage, @board_post
  end

  def create
    authorize! :create, BoardPost
    @board_post = current_user.board_posts.build(board_post_params)
    if @board_post.save
      redirect_to @board_post, notice: '投稿に成功しました'
    else
      render :new
    end
  end

  def update
    authorize! :manage, @board_post
    if @board_post.update(board_post_params)
      redirect_to @board_post, notice: '投稿を編集しました'
    else
      render :edit
    end
  end

  def destroy
    authorize! :manage, @board_post
    @board_post.destroy
    redirect_to history_board_posts_url, notice: '投稿を削除しました'
  end

  private

    def set_board_post
      @board_post = BoardPost.find(params[:id]).decorate
    end

    def set_my_board_post
      @board_post = current_user.board_posts.find(params[:id]).decorate
      redirect_to root_url unless current_user?(@board_post.user)
    end

    def board_post_params
      params.require(:board_post).permit(:title, :content, :purpose)
    end
end
