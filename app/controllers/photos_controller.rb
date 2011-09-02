class PhotosController < ApplicationController
 
  skip_before_filter :require_manager, :only => [:show]
  resource_controller

  belongs_to :wholesaler
  def create
    if params[:photo].nil?
      flash[:warning] = "Please select a jpeg or zip file for upload."
      redirect_to(new_wholesaler_photo_path(parent_object))
    elsif params[:photo] && params[:photo][:picture].content_type == ("application/zip" or "application/x-zip-compressed")
      count = create_from_zip(parent_object)
      flash[:notice] = "#{count} Photos Uploaded"
      redirect_to(wholesaler_photos_path(parent_object))
    else
      @photo = Photo.create(params[:photo])
      @photo.wholesaler = parent_object
      if @photo.save
        flash[:notice] = "Photo uploaded successfully"
        redirect_to(wholesaler_photos_path(parent_object))
      else
        flash[:warning] = "There was a problem with your upload.  Is the file in the jpeg format?"
        redirect_to(new_wholesaler_photo_path(parent_object))
      end
    end
  end

  private

  def create_from_zip(wholesaler)
    z = ZipExtractor.new(params[:photo][:picture].path)
    count = wholesaler.build_photos(z.extract_files(["jpg","jpeg"]))
    z.cleanup
    count
  end
end
