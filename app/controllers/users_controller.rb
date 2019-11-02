class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only:[:edit]

  def edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = '更新しました'
      redirect_to new_plan_path
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(
      :nickname,
      :introduction,
      :sex,
      :age,
      :height,
      :activity,
    )
  end

end
