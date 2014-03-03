class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def demo
  end

  def registration
    @user = default_user
    @micropost = Micropost.new(session[:micropost_params])
    @user.microposts << @micropost
  end
end