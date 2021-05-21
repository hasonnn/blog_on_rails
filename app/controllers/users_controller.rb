class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:new, :create]
    def new
        @user=User.new
    end
    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Logged In!"
        else
            flash[:alert] = 'Cannot use an existing email!'
            render :new
        end
    end
    def edit
        @user = User.find_by_id params[:id]
    end
    def update
        @user = User.find_by_id params[:id]
        if @user.update user_params
            redirect_to root_path, notice: "User information updated"
        else 
            flash[:alert] = 'Cannot use an existing email!'
            render :edit
        end
    end
    def edit_password
        @user = User.find_by_id params[:id]
    end
    def update_password
        @user = current_user
        if params[:user][:password] == params[:user][:current_password]
            flash[:alert] = "Current and New Password cannot be the same!"
            render :edit_password
        elsif @user&.authenticate(params[:user][:current_password])
            if @user.update user_params 
                redirect_to edit_user_path, notice: "Password successfully updated!"
            else
                flash[:alert] = "New Password and Confirmation Password does not match!"
                render :edit_password
            end
        else 
            flash[:alert] = "Current Password is incorrect! Please try again"
            render :edit_password
        end    
    end
    def panel
    end
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
    end
end
