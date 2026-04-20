class TransactionsController < ApplicationController
  def deposit
    account = @current_user.account
    account.deposit!(params[:amount])

    render json: { balance: account.balance.to_f, message: "Deposit successfully" }, status: :ok
  rescue ArgumentError, ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_content
  end
end
