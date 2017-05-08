class TagDecorator < Draper::Decorator
  delegate_all

  def display_name
    "##{name}"
  end
end
