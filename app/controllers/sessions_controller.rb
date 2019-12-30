class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
        )

        if user.nil?
            flash.now[:errors] = ["Incorrect username and/or password"]
            render :new
        else
            login!(user)
            session[:session_token] = current_user.try(:reset_session_token!)
            redirect_to user_url(current_user)
        end
    end

    def destroy
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
        redirect_to products_url
    end
end
