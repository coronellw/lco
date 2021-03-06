namespace :db do
	desc "File database with sample data"
	task populate: :environment do
		#User.create!(name: "Example user", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name, email: email, password: password, password_confirmation: password, admin: false)
		end

		#Creating some post for show up!
		usuarios = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5)
			usuarios.each { |user| user.microposts.create!(content: content) }
		end
	end
end