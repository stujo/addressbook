class SearchController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def contacts
    @search_form = SearchForm.new(search_params)
    if (@search_form.valid?)
      @contacts = @search_form.get_contacts.page(pagination_page_number).per(pagination_page_size)
    end
  end

  private
  def search_params
    params.require(:search_form).permit(:q)
  end

end
