class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate, :thanks, :new_activation_mail, :create_activation_mail]
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:edit, :update, :initial_edit, :initial_update]
  before_action :create_visit_history, only: [:show]

  def index
    @q = User.search(params[:q])
    other_sex = current_user.sex.male? ? :female : :male
    @users = @q.result(distinct: true).with_sex(other_sex).active.includes(:user_options, :display_unsubscribe_users).order("main_profile_image IS NULL ASC", last_logged_in_at: :desc).page(params[:page]).decorate
  end

  def show
    @user = @user.decorate
  end

  def new
    @user = User.new
  end

  def initial_edit
    if current_user.initialized?
      redirect_to edit_user_url(current_user)
    else
      current_user.residence ||= Prefecture.find_by!(name: '東京都')
      render layout: 'plane_page'
    end
  end

  def initial_update
    @user.attributes = initial_user_params
    # 改行,半角スペース,全角スペースtrim
    @user.nickname.gsub!(/[\s　]/, '') if @user.nickname?
    if @user.save(context: :initial_update)
      redirect_to @user, notice: 'プロフィールの初期設定が完了しました'
    else
      render :initial_edit, layout: 'plane_page'
    end
  end

  def edit
    @user = current_user
    @user.profile_images.build if @user.profile_images.blank?
  end

  def create
    @user = User.new(user_params)
    @user.password ||= SecureRandom.urlsafe_base64 # dummy

    if @user.save
      redirect_to thanks_users_path(@user, t: @user.url_token)
    else
      render :new
    end
  end

  def thanks
    @user = User.find_by(url_token: params[:t]) if params[:t]
  end

  def update
    if user_params[:profile_images_attributes]&.select{|profile_image| profile_image['_destroy'] == 'false'}.keys.count > ProfileImage::MAX_NUM
      @user.errors.add(:profile_images, "は#{ProfileImage::MAX_NUM}枚まで設定可能です")
      render :edit and return
    end

    if @user.update(update_user_params)
      redirect_to @user, notice: 'プロフィール情報を更新しました'
    else
      render :edit
    end
  end

  def new_activation_mail
  end

  def create_activation_mail
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.activation_state == 'pending'
      @user.setup_activation
      @user.save
      UserMailer.activation_needed_email(@user).deliver_now
    end
    flash.now[:notice] = '本登録用メールアドレスを送信いたしました'
    render :new_activation_mail
  end

  def activate
    activation_token = params[:url_token] # ここではアクティベーショントークンとして扱う
    if (@user = User.load_from_activation_token(activation_token))
      @user.activate!
      auto_login(@user)
      redirect_to(initial_edit_users_path, notice: 'あなたの属性を入れてご利用ください')
    else
      not_authenticated
    end
  end

  private
    def set_user
      @user = User.find_by!(url_token: params[:url_token])
    end

    def set_current_user
      @user = current_user
    end

    def create_visit_history
      current_user.went_histories.create(to_user: @user) unless current_user?(@user) || current_user.has_option?(:hide_visit_history)
    end

    def initial_user_params
      params.require(:user).permit(:sex,
                                   :password,
                                   :nickname,
                                   :birthday,
                                   :birthplace_id,
                                   :residence_id,
                                   :height,
                                   :body_shape,
                                   :drinking,
                                   :smoking,
                                   :marital_relationship,
                                   :motivation,
                                   :occupation,
                                   :income,
                                   :property,
                                   :introduction,
                                  )

    end

    def user_params
      params.require(:user).permit(:email,
                                   :password,
                                   :birthplace_id,
                                   :residence_id,
                                   :height,
                                   :body_shape,
                                   :drinking,
                                   :smoking,
                                   :marital_relationship,
                                   :motivation,
                                   :occupation,
                                   :income,
                                   :property,
                                   :introduction,
                                   :main_profile_image,
                                   profile_images_attributes: [:id, :photo, :status, :_destroy]
                                  )
    end

    def update_user_params
      # 所得証明が承認済みの場合 :income はアップデートさせない
      if @user.income_credential_approved?
        params.require(:user).permit(:email,
                                     :password,
                                     :birthplace_id,
                                     :residence_id,
                                     :height,
                                     :body_shape,
                                     :drinking,
                                     :smoking,
                                     :marital_relationship,
                                     :motivation,
                                     :occupation,
                                     :property,
                                     :introduction,
                                     :main_profile_image,
                                     profile_images_attributes: [:id, :photo, :status, :_destroy]
                                    )
      else
        user_params
      end
    end
end
