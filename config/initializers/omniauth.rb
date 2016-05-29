Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '249302212097251', '7c8b23a077edd12e6bc287ee6b0740f0'
end