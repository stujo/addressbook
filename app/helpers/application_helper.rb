module ApplicationHelper
  def search_form_parameters
    params.require(:search_form).permit(:q) if params.has_key? :search_form
  end
end
