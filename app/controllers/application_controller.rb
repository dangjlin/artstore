class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied!"
  redirect_to root_url
end

 def after_sign_in_path_for(resource)
   if resource.is_a?(User)
     if User.count == 1
       resource.add_role 'admin'
     else
       resource.add_role 'customer'
     end
     resource
   end
   root_path
 end

  def admin_required
    current_user.admin?
  end
  

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def find_cart

    cart = Cart.find_by(id: session[:cart_id])

    unless  cart.present?
      cart = Cart.create
    end

    session[:cart_id] = cart.id
    cart
  end

end
