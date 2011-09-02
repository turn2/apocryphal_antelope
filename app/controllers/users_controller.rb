class UsersController < ApplicationController
  resource_controller :singleton
  belongs_to :wholesaler

  create do
    after { object.confirm_email! }
    flash { "User #{object.email} created successfully" }
    wants.html { redirect_to edit_wholesaler_path(parent_object) }
  end

  update do 
    flash { "#{object.email}'s password changed successfully" }
    wants.html { redirect_to edit_wholesaler_path(parent_object) }
  end
end
