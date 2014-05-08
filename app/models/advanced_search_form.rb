class AdvancedSearchForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :zip, :sorting

  def persisted?
    false
  end

  def first_name_scope scope
    if self.first_name.blank?
      scope
    else
      scope.where(first_name: self.first_name)
    end
  end

  def last_name_scope scope
    if self.last_name.blank?
      scope
    else
      scope.where(last_name: self.last_name)
    end
  end


  def zip_scope scope
    if self.zip.blank?
      scope
    else
      scope.includes(:addresses).where("addresses.zip" => self.zip)
    end
  end


  def sorting_scope scope

    if self.sorting.blank?
      scope
    else
      case self.sorting
        when "oldest"
          scope.order(:dob)
        when "youngest"
          scope.order(:dob => :desc)
        else
          scope
      end
    end
  end

  def get_contacts

    scope = starting_scope

    # Add Each Scope
    # Each of these methods just returns the original scope if
    # it is not doing any filtering
    scope = first_name_scope(scope)
    scope = last_name_scope(scope)
    scope = zip_scope(scope)
    scope = sorting_scope(scope)

    scope
  end

  def starting_scope
    Contact.all
  end

end
