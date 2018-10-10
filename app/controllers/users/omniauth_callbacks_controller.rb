class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    callback_from :twitter
  end

  def failure
    redirect_to root_path
  end

  private
  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      print("persisted true")
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to root_path
      print("persisted false")

      # session["devise.#{provider}_data"] = request.env['omniauth.auth']
      # redirect_to controller: 'sessions', action: 'new'
    end
  end
end
