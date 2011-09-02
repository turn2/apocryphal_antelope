module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/i
      root_path
    when /the contact us page/i
      contact_path
    when /the sign in page/i
      new_session_path
    when /the follow the tour page/i
      follow_the_tour_path
    when /the password reset request page/i
      new_password_path
    when /the password change page for the wholesaler "(.+)"/i
      edit_wholesaler_user_path(Wholesaler.find_by_wholesaler_name($1))
    when /the Links page/i
      links_path
    when /the task dashboard/i
      task_dashboard_path
    when /the follow-up dashboard/i
      followups_path
    when /the complete follow-up dashboard/i
      followups_path(:complete=>'true')
    when /the incomplete follow-up dashboard/i
      followups_path
    when /the "(.+)" task page/i
      task = Task.find_by_title($1)
      wholesaler_task_path(task.wholesaler, task)
    when /the task manager page/i
      task_templates_path
    when /the new task template page/i
      new_task_template_path
    when /the "(.+)" task template edit page/i
      edit_task_template_path(TaskTemplate.find_by_title($1))
    when /the "(.+)" task template page/i
      task_template_path(TaskTemplate.find_by_title($1))
    when /the wholesaler dashboard/i
      wholesalers_path
    when /the wholesaler management page/i
      wholesalers_path
    when /the new wholesaler page/i
      new_wholesaler_path
    when /the wholesaler page for "(.+)"/i
      wholesaler_path(Wholesaler.find_by_wholesaler_name($1))
    when /the edit page for the wholesaler "(.+)"/i
      edit_wholesaler_path(Wholesaler.find_by_wholesaler_name($1))
    when /the winners page/i
      winners_path
    when /the photos page for "(.+)"/i
      wholesaler_photos_path(Wholesaler.find_by_wholesaler_name($1))
    when /the new photo page for "(.+)"/i
      new_wholesaler_photo_path(Wholesaler.find_by_wholesaler_name($1))
    when /that photo page for "(.+)"/i
      wholesaler = Wholesaler.find_by_wholesaler_name($1)
      wholesaler_photo_path(wholesaler, wholesaler.photos.last)
    when /the wholesaler batch upload page/i
      upload_wholesalers_path
    when /the public relations dashboard/i
      regions_path
    when /the page for the region "(.+)"/i
      region_path(Region.find_by_region_name($1))
    when /the edit page for the region "(.+)"/i
      edit_region_path(Region.find_by_region_name($1))
    when /the "(.+)" region edit page/i
      edit_region_path(Region.find_by_region_name($1))
    when /the "(.+)" region page/i
      region_path(Region.find_by_region_name($1))
    when /the page for the "(.+)" media outlet for the "(.+)" region/i
      region_media_outlet_path(Region.find_by_region_name($2), MediaOutlet.find_by_media_outlet_name($1))
    when /the conquest upload page/i
      new_plumber_path
    when /the new faq page/i
      new_faq_path
    when /the public faq page/i
      faqs_path
    when /the manage faqs page/i
      manage_faqs_path
    when /the published testimonials page/i
      testimonials_published_testimonials_path
    when /the wholesalers testimonials page/i
      testimonials_wholesalers_testimonials_path
    when /the unpublished testimonials page/i
      testimonials_unpublished_testimonials_path
    when /the Links page/i
      "/links"
    when /the Calculator tab/i
      "/calculator"
    when /the "Wholesalers at a Glance" page/i
      "/progress"

    # external paths
    when /the American Standard Savings Calculator page/i
      "http://www.americanstandard-us.com/Microsite/WaterEfficiency/"

    # Add more page name => path mappings here
    
    when /the Schedules page/i
      schedules_path
    when /the water savings edit page/i
      edit_water_saving_path
    when /the water savings page/i
      water_saving_path
    when /the prospects page/i
      prospects_path
    when /the edit page for a prospect/i
      edit_prospect_path(Prospect.first)
    when /the subscription page/i
      subscription_path
    when /my dashboard/i
      dashboard_path
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end
 
World(NavigationHelpers)
