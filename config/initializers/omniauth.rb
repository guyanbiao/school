Rails.application.config.middleware.use OmniAuth::Builder do

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
  provider :github, '98c79eb67479b5cf4ff3', '1e82591ecd520522959711acffc58400620cb071'
end
