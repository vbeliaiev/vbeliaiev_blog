class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :set_categories, only: %i[index show new edit]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_categories
    @current_category = Category.find_by(id: params[:category_id])
    @categories = Category.select(:id, :name).order(name: :asc)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to root_path
  end
end
