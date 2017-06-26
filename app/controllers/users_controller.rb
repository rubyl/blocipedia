class UsersController < ApplicationController
  def index
  end

  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    if @user.save
     flash[:notice] = "You've been downgraded to standard."
     redirect_to :back
    else
     flash[:error] = "There was an error creating your account. Please try again."
     redirect_to :back
    end
  end
end
