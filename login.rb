require 'oauth'
require 'twitter'

ctoken = ''
csecret = ''
url = 'http://api.twitter.com'

p 'Login? yes/no'
login = gets.chomp!

if login == 'yes'
	oa = OAuth::Consumer.new(ctoken, csecret, :site => url, :request_endpoint => url, :sign_in => true)
	rt = oa.get_request_token
	rsecret = rt.secret
	rtoken = rt.token
	
	auth_url = "http://api.twitter.com/oauth/authorize?oauth_token="+rtoken
	system("firefox "+auth_url)
	
	p 'Put yes when login'
	login = gets.chomp!
	if login == 'yes'
		at = rt.get_access_token
		asecret = at.secret
		atoken = at.token
		
		Twitter.configure do |config|
			config.consumer_key = ctoken
			config.consumer_secret = csecret
			config.oauth_token = atoken
			config.oauth_token_secret = asecret
		end
		
		client = Twitter::Client.new
		
		p 'Put your twit here:'
		twit = gets.chomp!
		
		client.update(twit);
	end
end

p 'Finish!'
