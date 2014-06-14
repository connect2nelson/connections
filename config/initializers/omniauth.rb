
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
           :issuer                             => ENV['AUTH_ISSUER'],
           :idp_sso_target_url                 => ENV['AUTH_TARGET_URL'],
           :idp_cert                           => ENV['AUTH_CERT'],
           :idp_cert_fingerprint               => ENV['AUTH_FINGERPRINT'],
           :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress",
           :idp_sso_target_url_runtime_params  => {:redirectUrl => :RelayState}
end