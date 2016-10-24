module PublicHelper

  def public_navbar_link(text:'', path:'')
    klass = current_page?(path) ? 'active' : url_for(path)
    content_tag(:li, class: klass) do
      (link_to text, path)
    end
  end
end

