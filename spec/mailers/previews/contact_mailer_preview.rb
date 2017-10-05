# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_email_preview
    ContactMailer.contact_email(User.first, "Hello World", "Content of the email.")
  end
end
