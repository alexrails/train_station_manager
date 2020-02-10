module ValidDefinition

  def valid?
    validate!
    true
  rescue
    false
  end

end

