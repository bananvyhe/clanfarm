class News < ApplicationRecord
	require 'net/http'
	require 'uri'
	def self.tokenmake
		uri = URI.parse("https://iam.api.cloud.yandex.net/iam/v1/tokens")
		request = Net::HTTP::Post.new(uri)

		request.body = JSON.dump({
		  "yandexPassportOauthToken" => Rails.application.credentials.yaOauth
		})
		req_options = {
			use_ssl: uri.scheme == "https",
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			 @tokwars =  http.request(request).body
		end
		# response.code
		# response.body
		formj = JSON.parse(@tokwars)
		tokenrapid = "bearer " + formj['iamToken']
	end		
end
