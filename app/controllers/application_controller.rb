class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def prep_pagination scope
    @pagintation_scopes ||= []
    #Save for Debugging
    @pagintation_scopes.push scope

    scope.page(pagination_page_number).per(pagination_page_size)
  end

  def pagination_page_number
    @page_number = 1
    @page_number = params[:page] if params.has_key? :page
  end

  def pagination_page_size
    10
  end


end
