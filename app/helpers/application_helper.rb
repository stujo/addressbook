module ApplicationHelper
  def search_form_parameters
    params.require(:search_form).permit(:q) if params.has_key? :search_form
  end

  def address_types_for_select
    Address.address_types
  end

  def contact_type_field sf, resource, field, item_wrapper_class = 'inline'

    selected = convert_enum(resource.send(field))
    sf.input field, label: 'Type', collection: address_types_for_select, as: :radio_buttons, checked: selected, item_wrapper_class: item_wrapper_class

  end

  def convert_enum sym
    Address.address_types[sym]
  end

  def contact_type_icon resource_type

    glyph = nil

    case resource_type.to_sym
      when :is_home
        glyph = 'home'
      when :is_office
        glyph = 'briefcase'
      when :is_other
        glyph = 'globe'
    end unless resource_type.blank?

    if glyph.blank?
      ''
    else
      raw "<span class='glyphicon glyphicon-#{glyph}'></span>"
    end

  end

end
