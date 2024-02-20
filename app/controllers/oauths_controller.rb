class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider)

    if @user
      successful_login(provider)
    else
      attempt_signup_and_login(provider)
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def successful_login(provider)
    redirect_to root_path, notice: I18n.t('oauth.login_success', provider: provider.titleize)
  end

  def attempt_signup_and_login(provider)
    signup_and_login(provider)
    redirect_to root_path, notice: I18n.t('oauth.login_via_provider', provider: provider.titleize)
  rescue StandardError
    redirect_to root_path, alert: I18n.t('oauth.login_failure', provider: provider.titleize)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
