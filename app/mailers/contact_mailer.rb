# app/mailers/contact_mailer.rb

class ContactMailer < ApplicationMailer
    def send_email(email_to, subject, email_text, headers)
      @email_to = email_to
      @subject = subject
      @email_text = email_text
      mail(to: @email_to, subject: @subject, body: @email_text, content_type: "text/plain", header: headers)
    end
  end
  