class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor_auth] = true
        user.generate_pin!

        #user.send_pin_to_twilio

        redirect_to pin_path

        #if there is a phone number present:
        #1. generate a pin
        #2. save it
      else
        session[:user_id] = user.id
        flash[:notice] = "You've logged in!"
        redirect_to root_path
      end

    else
      flash[:error] = "There's something wrong with your username or password"
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end

  def pin
    access_denied if session[:two_factor_auth].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor_auth] = nil
        #remove pin
        user.remove_pin!
        #normal login success
        session[:user_id] = user.id
        flash[:notice] = "You've logged in!"
        redirect_to root_path
      else
        #no need to render template because pin is a non model backed form
        flash[:error] = "Sorry, incorrect pin number!"
        redirect_to pin_path
      end
    end
  end

end
