class UserMailer < ActionMailer::Base
  default from: "zhzenghui@gmail.com"

   def welcome_email(user)
    @user = user
    @url  =  Setting.domain_signup
    mail(to: @user.email,
         subject: 'Welcome to My Awesome Site')
   end
   
   def receive(email)
       page = Page.find_by_address(email.to.first)
       page.emails.create(
         :subject => email.subject,
         :body => email.body
       )
 
       if email.has_attachments?
         email.attachments.each do |attachment|
           page.attachments.create({
             :file => attachment,
             :description => email.subject
           })
         end
       end
   end
end
