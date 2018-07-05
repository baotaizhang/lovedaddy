class UserReportsController < ApplicationController

  def new
    authorize! :create, UserReport
    url_token = params[:t]
    @target_user = User.find_by(url_token: url_token)

    if @target_user.present?
      @user_report = UserReport.new(target_user: @target_user)
    else
      redirect_to root_path 
    end
  end

  def create
    authorize! :create, UserReport
    @user_report = UserReport.new(user_report_params)
    @user_report.report_user = current_user

    if @user_report.save
      UserReportMailer.to_operator(@user_report).deliver_now!
      redirect_to @user_report.target_user, notice: '通報しました'
    else
      render :new
    end
  end

  private

    def user_report_params
      params.require(:user_report).permit(:target_user_id, :reason_id, :detail_text)
    end
end
