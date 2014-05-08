module ContactsHelper

  def contacts_for_select
    Contact.all.collect { |m| [m.full_name, m.id] }
  end
end
