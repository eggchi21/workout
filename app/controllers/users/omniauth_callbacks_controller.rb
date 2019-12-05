class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.find_omniauth(request.env["omniauth.auth"]) #メソッドの3パターンのどれか
    session[:uid] = request.env["omniauth.auth"][:uid]
    session[:provider] = provider.to_s
    session[:user] = @user

    if @user.persisted? #(パターン①②)
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else #(パターン③)
      session[:nickname]=@user.nickname
      session[:email]=@user.email
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except("extra")
      redirect_to step2_signup_index_path
    end
  end

  def failure
    redirect_to root_path
  end
end
