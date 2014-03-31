module CsessionsHelper
  def sign_in(customer)
    remember_token = Customer.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    customer.update_column(:remember_token, Customer.hash(remember_token))
    self.current_customer = customer
  end

  def current_customer=(customer)
    @current_customer = customer
  end

  def current_customer
    remember_token = Customer.hash(cookies[:remember_token])
    @current_customer ||= Customer.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_customer.nil?
  end

  def sign_out
    current_customer.update_attribute(:remember_token, Customer.hash(Customer.new_remember_token))
    cookies.delete(:remember_token)
    self.current_customer = nil
  end
end
