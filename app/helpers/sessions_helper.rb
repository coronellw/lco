module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
      if !signed_in?
        store_location
        flash[:notice] = "Please sign in to perform this action." 
        redirect_to signin_url
      end
    end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])	
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user?(user)
		user == current_user
	end

	def default_user
		if default_in_memory?
			@default_user
		else
			@default_user = User.new
		end
	end

	def default_in_memory?
		!@default_user.nil?
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		begin
			session[:return_to] = request.url if request.get
		rescue Exception => e
			session[:return_to] = nil
		end
	end
end
