class TransactionController < ApplicationController
  before_action   :check_admin, only: [:authorize_index, :authorize_edit, :authorize_reject, :authorize_approve]
  before_action   :check_sub_admin, only: [:edit_balance, :update_balance]

  before_action   :new_transaction, only: [:deposit_new, :withdraw_new]
  before_action   :set_transaction, only: [:authorize_reject, :authorize_edit, :authorize_approve]

  def account_history
    @result = Transaction.where(:user_id => current_user.id, :change_date.ne => nil).order_by(change_date: 1).map do |x|
      [x.change_date.to_s, x.current_value.to_s.to_i]
    end
  end

  def deposit_index
    @transactions = Transaction.where(user_id: current_user.id, _mode: :add_funds).order(updated_at: :desc)
  end

  def deposit_new
  end

  def deposit_create
    transaction = Transaction.new(change_value: deposit_params[:change_value], user: current_user,
      status: :status_intialized, mode: :add_funds)
    if transaction.save
      redirect_to :root, notice: "Your transaction is successfully logged."
    else
      redirect_to :back, alert: "Transaction not logged. Errors: #{transaction.errors.messages}"
    end
  end

  def withdraw_index
    @transactions = Transaction.where(user_id: current_user.id, _mode: :withdraw_funds).order(updated_at: :desc)
  end

  def withdraw_new
  end

  def withdraw_create
    transaction = Transaction.new(withdraw_params)
    transaction.user = current_user
    transaction.status = :status_intialized
    transaction.mode = :withdraw_funds
    if transaction.save
      redirect_to :root, notice: "Your transaction is successfully logged."
    else
      redirect_to :back, alert: "Transaction not logged. Errors: #{transaction.errors.messages}"
    end
  end

  def authorize_index
    @transactions = Transaction.includes(:user).where(:_mode.in => [:add_funds, :withdraw_funds], _status: :status_intialized).
      order(updated_at: :desc)
  end

  def authorize_reject
    # TODO: wrap in transaction
    @transaction.status = :status_rejected
    @transaction.finalized_by = current_user
    if @transaction.save
      redirect_to :back, notice: "Transaction successfully rejected."
    else
      redirect_to :back, alert: "Transaction not saved. Errors: #{@transaction.errors.messages}"
    end
  end

  def authorize_edit
  end

  def authorize_approve
    # TODO: wrap in transaction
    auth_params = authorize_params
    @user = @transaction.user
    @transaction.status = :status_approved
    @transaction.change_value = auth_params[:change_value]
    @transaction.finalized_by = current_user
    @transaction.change_date = Time.now
    @transaction.prev_value = @transaction.user.finance.balance.to_f
    change = Money.new(auth_params[:change_value].to_f * 100)
    if @transaction.add_funds?
      @user.finance.balance += change
      @transaction.current_value = @user.finance.balance
    elsif @transaction.withdraw_funds?
      @user.finance.balance -= change
      @transaction.current_value = @user.finance.balance
    end
    if @transaction.save && @user.save
      redirect_to :transaction_authorize_index, notice: "Transaction & User successfully accepted."
    else
      redirect_to :transaction_authorize_index, alert: "Transaction not saved. Errors: #{@transaction.errors.messages}"
    end
  end

  def edit_balance
    @users = User.all
  end

  def update_balance
    update_list = update_params[:update]
    update_list.each do |update|
      value = update[:current_value]
      next if value.blank?
      user = User.find(update[:user_id])
      new_value_money = Money.new(value.to_f * 100)
      Transaction.create(
        prev_value: user.finance.balance,
        current_value: new_value_money,
        change_value: new_value_money - user.finance.balance,
        user_id: user.id,
        change_date: Time.now,
        finalized_by_id: current_user.id,
        status: :status_not_required,
        mode: :value_update
      )
      user.finance.update_attribute(:balance, new_value_money)
    end
    redirect_to :transaction_edit_balance, notice: "Balance updated successfully."
  end

  protected

  def new_transaction
    @transaction = Transaction.new
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def deposit_params
    params.require(:transaction).permit(:change_value, :user_notes)
  end

  def withdraw_params
    params.require(:transaction).permit(:change_value, :user_notes, :accept_terms_and_conditions,
      bank_detail_attributes: [:full_name, :address, :account, :bank_name,
      :swift_code, :bank_address, :branch_name, :branch_code, :inter_swift_code,
      :inter_bank_name, :inter_bank_address])
  end

  def authorize_params
    params.require(:transaction).permit(:change_value)
  end

  def update_params
    params.require(:transaction).permit(update: [:user_id, :current_value])
  end
end
