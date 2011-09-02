# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_flash
    [:notice, :warning, :message, :failure, :success].collect do |key|
      content_tag(:div, flash[key], :class => "flash flash_#{key}") unless flash[key].blank?
    end.join
  end

  def states_for_select
    Geography::STATES.dup.unshift [ "-- Select State --", nil]
  end

  def states_and_provinces_for_select
    Geography::STATES_AND_PROVINCES.dup.unshift [ "-- Select State or Province --", nil]
  end
end
