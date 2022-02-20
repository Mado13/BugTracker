module ApplicationHelper
  def present(object, klass = nil, current_user)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self, current_user)
    yield presenter if block_given?
    presenter
  end
end
