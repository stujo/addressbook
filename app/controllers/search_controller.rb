class SearchController < ApplicationController

  skip_before_filter :verify_authenticity_token


  def quick_search
    @search_form = SearchForm.new(params.permit(:q))
    run_search
  end

  def advanced_search
    @search_form = SearchForm.new(search_params)
    run_search
  end

  private

  def run_search
    if (@search_form.valid?)
      @contacts = @search_form.get_contacts.page(pagination_page_number).per(pagination_page_size)
    end
    render :search_contacts
  end

  def search_params
    params.require(:search_form).permit(:q)
  end

end
