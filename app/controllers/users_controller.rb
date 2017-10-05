class UsersController < ApplicationController
  before_action   :check_admin
  before_action   :set_user, only: [:show, :edit, :update, :history]

  def index
    @users = User.order_by(updated_at: -1)
  end

  def show
  end

  def history
    @transactions = @user.transactions.where(:_mode.in => [:add_funds, :withdraw_funds]).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: "User Successfully Updated."
    else
      render :edit, alert: "There were some errors in the document. #{@user.errors.messages}"
      Rails.logger.debug("#{@user.errors.messages}")
    end
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params.require(:user).permit(:email, :mobile, :password, :password_confirmation, :security_setting, :blocked_status,
      gen_info_attributes: [:id, :first_name, :last_name, :date_of_birth, :uk_resident],
      address_attributes: [:id, :address_line, :city, :state, :zip],
      finance_attributes: [:id, :finance_plan_id, :account_number])
  end

end
