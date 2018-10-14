class ApplicationController < ActionController::Base
  before_action :ensure_domain

  FQDN = 'brushapp.me'
  # redirect correct server from herokuapp domain for SEO
  def ensure_domain
   return unless /\.herokuapp.com/ =~ request.host

   redirect_to "#{request.protocol}#{FQDN}#{request.path}", status: :moved_permanently
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_url
  end

end
