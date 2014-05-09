class AdvancedSearchForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :zip, :phone, :sorting

  attr_accessor :preload_addresses, :preload_phones


  validates_format_of :zip,
                      :with => %r{\d{5}(-\d{4})?},
                      :message => "should be 12345 or 12345-1234",
                      :allow_blank => true

  def persisted?
    false
  end


  def get_contacts
    scope = Contact.all.uniq
    add_scope_filters scope
  end

  private
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
      scope.joins(:addresses).where("addresses.zip" => self.zip)
    end
  end

  def phone_scope scope
    if self.phone.blank?
      scope
    else
      scope.joins(:phones).where("phones.digits LIKE :phone_like_match", {phone_like_match: "%#{self.phone}%"})
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


  def add_scope_filters scope

    # Add Each Scope
    # Each of these methods just returns the original scope if
    # it is not doing any filtering
    scope = first_name_scope(scope)
    scope = last_name_scope(scope)
    scope = zip_scope(scope)
    scope = phone_scope(scope)
    scope = sorting_scope(scope)

    include_pre_loads scope
  end

  def include_pre_loads scope
    #Pre load associations if instructed
    if @preload_addresses
      scope = scope.includes(:addresses);
    end
    if @preload_phones
      scope = scope.includes(:phones);
    end
    scope
  end

end
