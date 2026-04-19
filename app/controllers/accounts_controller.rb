class AccountsController < ApplicationController
  def balance
    render json: { balance: @current_user.account.balance.to_f }, status: :ok
  end
end
