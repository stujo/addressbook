class SearchController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def contacts
    @search_form = SearchForm.new(search_params)
    if (@search_form.valid?)
      @contacts = @search_form.get_contacts.page(pagination_page_number).per(pagination_page_size)
    end

    #Empty Advanced Search Form
    @advanced_search_form = AdvancedSearchForm.new
  end

  def advanced_contacts
    @advanced_search_form = AdvancedSearchForm.new(advanced_search_params)
    if (@advanced_search_form.valid?)
      @contacts = @advanced_search_form.get_contacts.page(pagination_page_number).per(pagination_page_size)
    end

    render :contacts
  end


  private
  def search_params
    # I would like to put this in the SearchForm class but left it here to be clearer
    params.require(:search_form).permit(:q)
  end

  def advanced_search_params
    # I would like to put this in the AdvancedSearchForm class but left it here to be clearer
    params.require(:advanced).permit(:last_name, :first_name, :zip, :sorting)
  end

end
