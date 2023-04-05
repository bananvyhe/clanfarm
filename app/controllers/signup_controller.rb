class SignupController < ApplicationController
  def create
    puts params
    if user_find 
       render json: { errors: "Емайл уже зарегистрирован." }
    else
      loa = params[:loa]
      if  params[:loa] == nil
      loa = 0
      elsif  params[:loa] > 1000
      loa = 1000
      end

      user = User.new({:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation], :loa => loa})

      if user.save
        payload  = { user_id: user.id, aud: [user.role]}
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        tokens = session.login

        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production?)
        render json: { csrf: tokens[:csrf] }
      else
        render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
      end
    end  
  end

  private
  def user_find
    User.find_by(email: params[:email])
  end
  def user_params
    params.permit(:email, :password, :password_confirmation, :loa)
  end
end