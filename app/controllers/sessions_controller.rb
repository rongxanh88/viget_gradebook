class SessionsController < ApplicationController
  before_action :validate_login, only:[:create]

  def create
    if current_user
      if current_user.teacher?
        redirect_to teacher_dashboard_index_path
      elsif current_user.student?
        redirect_to student_dashboard_index_path
      elsif current_user.admin?
        redirect_to admin_dashboard_index_path
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: 'Successfully Logged Out'
  end

  private

  def validate_login
    @user = User.find_by(username: params[:user][:username].downcase)

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      current_user = @user
    else
      redirect_to root_path, notice: 'Login Failed'
    end
  end
end