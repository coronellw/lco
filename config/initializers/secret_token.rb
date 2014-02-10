# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

#require 'securerandom'

#def secure_token
#	token_file = Rails.root.join('.secret')
#	if File.exist?(token_file)
#		#Use the existing token
#		File.read(token_file).chomp
#	else
#		#generate a new token
#		token = SecureRandom.hex(64)
#		File.write(token_file, token)
#	end
#end

#LCO::Application.config.secret_key_base = secure_token
LCO::Application.config.secret_key_base = '4022c50732f988a214a2c5838b03616ebb05663d3597b48593873140290b237239db91bb5c46d3fce20938c53bbc0462e75fde18d01faf2ea715ffc664b76ae9'