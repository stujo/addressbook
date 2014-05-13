class SearchController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def pagination_page_size
    4 # Because we display full data
  end


  def contacts
    @search_form = SearchForm.new(search_params)
    if (@search_form.valid?)
      @contacts = prep_pagination @search_form.search Contact.all, :first_name
    end
  end

  def advanced_contacts
    @advanced_search_form = AdvancedSearchForm.new(advanced_search_params)
    if (@advanced_search_form.valid?)
      @advanced_search_form.preload_phones = true
      @advanced_search_form.preload_addresses = true
      @contacts = prep_pagination @advanced_search_form.get_contacts
    end
  end

  def ransack
    @search = Contact.search(params[:q])
    @contacts = prep_pagination(@search.result, 10)

    # Only required if we are using the complex form
    @search.build_condition

    # Only required if we are using sorting
    @search.build_sort if @search.sorts.empty?
  end

  private
  def advanced_search_params
    if (params.has_key? :advanced)
      # I would like to put this in the AdvancedSearchForm class but left it here to be clearer
      params.require(:advanced).permit(:last_name, :first_name, :zip, :phone, :sorting)
    end
  end

  def search_params
    if (params.has_key? :search_form)
      # I would like to put this in the SearchForm class but left it here to be clearer
      params.require(:search_form).permit(:q)
    end
  end

end
