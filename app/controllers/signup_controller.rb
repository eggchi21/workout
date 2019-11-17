class SignupController < ApplicationController
  before_action :validates_step2, only: :step3
  before_action :validates_step3, only: :create

  def step1
  end

  def reset
    session[:nickname] = nil
    session[:email] = nil
    session[:provider] = nil
    session[:password] = nil
    session[:password_confirmation] = nil
    redirect_to step2_signup_index_path
  end
  def step2
    @user = User.new
  end

  def step3
    @user = User.new
    @user.build_address
  end

  def create
    @user = User.new(
                      nickname: session[:nickname],
                      email: session[:email],
                      password: session[:password],
                      password_confirmation: session[:password_confirmation]
                    )
    @user.build_address(user_params[:address_attributes])
    if @user.save
      # if session[:provider] != nil
      #   SocialProfile.create(
      #     uid: session[:uid],
      #     provider: session[:provider],
      #     user_id: @user.id
      #     )
      # end
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render step2_signup_index_path
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
    redirect_to root_path,notice: 'ようこそ' + session[:nickname] + 'さん！ まずは「ユーザー情報」から身長や性別を登録しましょう！'

  end

  private

  def validates_step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    if  session[:provider] != nil
      session[:password] = Devise.friendly_token.first(6)
      session[:password_confirmation] =session[:password]
    else
      session[:password] = user_params[:password]
      session[:password_confirmation] = user_params[:password_confirmation]
    end
    @user = User.new(
                      nickname: session[:nickname],
                      email: session[:email],
                      password: session[:password],
                      password_confirmation: session[:password_confirmation]
                    )
    render step2_signup_index_path unless @user.valid?
  end

  def validates_step3
    session[:postcode] = params[:user][:address_attributes][:postcode]
    session[:prefecture_code] = params[:user][:address_attributes][:prefecture_code]
    session[:city] = params[:user][:address_attributes][:city]
    session[:address1] = params[:user][:address_attributes][:address1]

    @user = User.new
    @user.build_address
    @address = Address.new(
                            postcode: session[:postcode],
                            prefecture_code: session[:prefecture_code],
                            city: session[:city],
                            address1: session[:address1]
                          )
    render step3_signup_index_path unless @address.valid?
  end

  def user_params
    params.require(:user).permit(
                                  :nickname,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  address_attributes: [:id,
                                                        :postcode,
                                                        :prefecture_code,
                                                        :city,
                                                        :address1,
                                                        :address2]
                                )
  end

end