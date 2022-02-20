class ProjectDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

end
