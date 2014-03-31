class CsessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    customer = Customer.find_by(email: params[:csession][:email].downcase)
    if customer && customer.authenticate(params[:csession][:password])
      sign_in customer
      redirect_to customer
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to store_url
  end
end
