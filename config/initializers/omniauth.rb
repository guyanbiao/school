Rails.application.config.middleware.use OmniAuth::Builder do

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }, on_failed_identity: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
  provider :github, 'b17bf7e9a488badd6575', 'b306d28789953a251a8f0922fa628d628d98ca84'
end
