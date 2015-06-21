module SessionHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  def not_signed_user
    unless signed_in?
      flash[:danger] = "You need to sign in or sign up before continuing."
      redirect_to root_path
    end
  end

  def authenticate_admin
    unless current_user.is_admin?
      flash[:danger] = "You need to sign in as administrator before continuing."
      redirect_to root_path
    end
  end
end
