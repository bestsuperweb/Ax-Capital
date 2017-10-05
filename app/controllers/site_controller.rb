class SiteController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:home, :about_us, :strategies, :fund_security, :regulations, :faq,
    :contacts, :privacy, :risk, :preventing, :security, :terms]

  def home
  end

  def index
  end

  def contacts
  end

  def send_contact_mailer
    sanitized_params = mailer_params
    source_user = current_user || User.new(email: "anonymous@site.com")
    ContactMailer.contact_email(source_user, sanitized_params[:subject],
      sanitized_params[:body], sanitized_params[:dept]).deliver_now
    redirect_to :root, notice: "Email Sent Successfully."
  end

  def confirm_otp
    if current_user.sms_confirmed_at
      redirect_to :back, alert: "User already confirmed."
    elsif !params[:otp]
      redirect_to :back, alert: "OTP Parameter missing."
    elsif params[:otp] != current_user.sms_otp
      redirect_to :back, alert: "OTP mismatch."
    elsif current_user.sms_confirmation_sent_at + ApplicationCustomConfig[:sms_confirm_with] < Time.now
      redirect_to :back, alert: "OTP expired."
    else
      current_user.update_attribute(:sms_confirmed_at, Time.now)
      redirect_to :back, notice: "OTP Successfully Confirmed."
    end
  end

  def resend_otp
    current_user.generate_otp_and_send(true)
    current_user.save
    redirect_to :back, notice: "New OTP sent Successfully."
  end

  def privacy
  end

  def risk
  end

  def preventing
  end

  def security
  end

  def terms
  end

  ## non-signed in content
  def about_us
  end

  def strategies
  end

  def fund_security
  end

  def regulations
  end

  def faq
  end

  protected

  def mailer_params
    params.require(:mailer).permit(:dept, :subject, :body)
  end
end