class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user! , :set_constants
    private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
    def set_constants
        @groups = Group.limit(5).all.order(created_at: :desc)
        @orders = Order.limit(5).all.order(created_at: :desc)
        @friends = Friend.limit(5).all.order(created_at: :desc)
    end
end
