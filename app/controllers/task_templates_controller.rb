class TaskTemplatesController < ApplicationController
  resource_controller

  create.flash "Task Template created successfully"
  destroy.flash "Task Template has been deleted"

end
