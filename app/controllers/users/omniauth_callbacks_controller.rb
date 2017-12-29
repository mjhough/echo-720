class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def microsoft_office365
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Office365') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to new_user_session_path, alert: 'Office365 Login Failed.'
  end
end
