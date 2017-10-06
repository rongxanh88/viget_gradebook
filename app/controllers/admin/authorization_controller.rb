class Admin::AuthorizationController < ApplicationController
  before_action :authorization
  
  def authorization
    if !current_user && !current_user.admin?
      render file: 'public/404', layout: false, status: 404
    end
  end
end