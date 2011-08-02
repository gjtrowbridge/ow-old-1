class UserMailer < ActionMailer::Base
  default :from => "admin@orangewalrus.com"
	def test
		mail(	:to => 'ivraft@gmail.com',
				:subject => 'Test email' )
	end
end
