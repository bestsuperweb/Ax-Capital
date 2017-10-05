class ContactMailer < ApplicationMailer
  default from: ENV['CONTACT_FROM_EMAIL']

  def contact_email(user, subject, content, dept)
    @user = user
    @subject = subject
    @content = content
    @dept = dept
    mail(to: ENV['CONTACT_TO_EMAIL'], subject: "#{@user.email} : contact form : #{subject}")
  end

  def plan_change_email(user, old_plan, new_plan)
    @user = user
    @old_plan = old_plan
    @new_plan = new_plan
    @verb = @old_plan ? "Changed" : "Set"
    mail(to: ENV['CONTACT_TO_EMAIL'], subject: "#{@user.email} #{@verb} plan to #{new_plan.name}")
  end
end
