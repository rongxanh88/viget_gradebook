class Student::AuthorizationController < ApplicationController
  before_action :authorization
  
  def authorization
    if !current_user && !current_user.student?
      render file: 'public/404', layout: false, status: 404
    end
  end
end