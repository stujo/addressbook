class SearchForm
  include ActiveModel::Model

  attr_accessor :q #Generic Search

  #validates_length_of :q, minimum: 3, message: 'Please enter at least 3 letters to search'

  def persisted?
    false
  end

  def add_q_query_if_present query
    unless self.q.blank?
      query = query.where("first_name = :q OR last_name = :q", {q: self.q})
    end
    query
  end


  def get_contacts
    query = Contact.all

    query = add_q_query_if_present(query)

    query
  end
end
