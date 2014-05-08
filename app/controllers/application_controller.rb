class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def pagination_page_number
    @page_number = 1
    @page_number = params[:page] if params.has_key? :page
  end

  def pagination_page_size
    5
  end
end
