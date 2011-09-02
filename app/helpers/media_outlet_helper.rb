module MediaOutletHelper
  def media_outlet_row_attributes(media_outlet)
    klasses = [ "media_outlet" ]
    klasses << cycle("light","dark", :name => "media_outlet_rows")

    return {:class => klasses.join(" "), :id => "media_outlet#{media_outlet[:id]}"}
  end

  def media_outlet_smart_path(media_outlet)
    if media_outlet.region
      region_media_outlet_path(media_outlet.region, media_outlet)
    else
      media_outlet_path(media_outlet)
    end
  end
end
