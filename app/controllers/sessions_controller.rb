class SessionsController < ApplicationController

  def new
    if session[:login_ban_time] and session[:login_ban_time] > Time.now
      render "max_tries" and return
    end
    @session = Session.new
  end

  def create
    @s = Session.new(params[:session])
    unless api_request?
      if @s.valid?
        @s.save
        redirect_to "/"
      else
        @session = @s
        render :action => :new
      end
    else
      puts "HANDLE_BY_TOKEN"
      unless @s.valid?
        flash.now[:errors] = @s.errors
        error(400)
      else
        render "token"
      end
    end
  end

  def token

  end

  def delete
  end

  def destroy
    current_session.destroy
    redirect_to "/"
  end
end
