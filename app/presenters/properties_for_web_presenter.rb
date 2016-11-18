class PropertiesForWebPresenter

  def highlighted_properties(limit=3)
    Property.highlighted.sample(limit)
  end
end
