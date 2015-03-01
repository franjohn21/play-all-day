class SessionsController < ApplicationController
  def new
  end

  def fb_create
    puts request.env['omniauth.auth'].info.image
    user = User.find_by_email(request.env['omniauth.auth'].info.email)
    if user 
      user.fb_id = request.env['omniauth.auth'].extra.raw_info.id
      user.img_url = request.env['omniauth.auth'].info.image
      user.name = request.env['omniauth.auth'].info.name
      user.save!
      session[:user_id] = user.id

    else
      user = User.create(email: request.env['omniauth.auth'].info.email, name: request.env['omniauth.auth'].info.name, fb_id: request.env['omniauth.auth'].extra.raw_info.id, password: 'facebook', img_url: request.env['omniauth.auth'].info.image) 
      session[:user_id] = user.id
    end
    redirect_to '/'
  end

  def create
    user = User.find_by_email(params[:email])
       # If the user exists AND the password entered is correct.
       if user && user.authenticate(params[:password])
         # Save the user id inside the browser cookie. This is how we keep the user 
         # logged in when they navigate around our website.
         session[:user_id] = user.id
         redirect_to '/'
       else
       # If user's login doesn't work, send them back to the login form.
         redirect_to '/login'
       end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/home'
  end
end
