module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

        def connect

puts "444"
# token = request.params[:token]
 # jwt_token = connection.request.headers['Authorization']&.split(' ')&.last
 # puts jwt_token
# ActionCable.server.broadcast 'RoomChannel', message: data[token]
#       puts session.masked_csrf(access_token)
         
#        jwt = JWT.decode token, Rails.application.secret_key_base, true, {algorithm: 'HS256'}
# puts jwt
     #      c
 
          # token = request.params[:token] 
      # if jwt_token.present?
      #   begin
          # decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
          # payload = decoded_token[0]
     
          # self.current_user = User.find(decoded_token['user_id'])
      #   rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      #     reject_unauthorized_connection
      #   end
      # else
      #   reject_unauthorized_connection
      # end          
 # decoded_token = JWT.decode token,  Rails.application.secret_key_base, true, { algorithm: "HS256" }
      # decoded_token = request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].split(' ').last
 
      # puts  decoded_token
    #   self.current_user = User.find(decoded_token['user_id'])
    # rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    #   reject_unauthorized_connection
    # end
 
   end
  end
end
