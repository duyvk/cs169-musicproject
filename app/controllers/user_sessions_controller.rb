class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    respond_to do |format|
      if @user_session.save
        current_user = UserSession.find
        id = current_user && current_user.record.id
        @user = User.find(id)
        @current_user = @user
        @playlists = @user.playlists
        @songs = @user.songs
        format.html { redirect_to(:root) } 
        format.js do
          render :update do |page|
            page.replace_html "main_content", :partial => 'users/show'
            page.replace_html "login_links", :partial => 'index/login_links'
            page.replace_html "nav", :partial => 'index/nav'
          end
        end
      else
        format.html { redirect_to(:root) } 
           format.js do
             render :update do |page| 
             flash[:error] = "Login Failed"
             page.replace_html "main_content", :partial => 'user_sessions/new'
          end
        end
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to(:root)
  end
end
