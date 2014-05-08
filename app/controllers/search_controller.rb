class SearchController < ApplicationController


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
      @contacts = @search_form.get_contacts.page(@oage_number).per(5)
    end
    render :search_contacts
  end

  def search_params
    params.require(:search_form).permit(:q)
  end

end
