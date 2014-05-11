class SearchForm
  include ActiveModel::Model

  attr_accessor :q #Generic NAME Search

  validates_length_of :q, minimum: 2, message: 'At least 2 letters'

  def persisted?
    false
  end

  def search scope, column_name
    unless self.q.blank?
      scope = scope.where(column_name => self.q)
    end
    scope
  end
end
