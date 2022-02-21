module ApplicationHelper
  def present(object, current_user, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, current_user, self)
    yield presenter if block_given?
    presenter
  end
end
