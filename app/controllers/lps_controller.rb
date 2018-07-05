class LpsController < ApplicationController
  skip_before_action :require_login
  layout 'unique_page'

  def date
    @user = User.new
  end
end

