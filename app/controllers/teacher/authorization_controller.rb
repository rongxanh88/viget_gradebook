class Teacher::AuthorizationController < ApplicationController
  before_action :authorization
  
  def authorization
    if current_user && !current_user.teacher?
      render_404
    elsif !current_user
      render_404
    end
  end
end