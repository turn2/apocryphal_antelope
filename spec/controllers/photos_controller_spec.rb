require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  def mock_wholesaler(stubs = {})
    @mock_wholesaler ||= mock_model(Wholesaler, stubs)
  end
 
  def mock_photo(stubs = {})
    @mock_photo ||= mock_model(Photo, stubs)
  end

  before(:each) do
    Wholesaler.stub!(:find).with("1").and_return(mock_wholesaler)
    sign_in_as_manager
  end
  
  it "should be resourceful" do
    controller.class.should include(ResourceController::Controller)
  end

  describe "POST create" do
   
    context "non-zip file" do
      it "should expose a newly created Photo as @photo" do
        Photo.should_receive(:create).and_return(mock_photo(:save => true))
        mock_photo.should_receive(:wholesaler=).with(mock_wholesaler)
        post :create, :photo => {:picture => mock_model(File, :content_type => "jpeg")}, :wholesaler_id => "1"
        assigns(:photo).should equal(mock_photo) 
      end   

      it "should redirect to the parent wholesaler's photos on success" do
        Photo.stub!(:create).and_return(mock_photo(:save => true).as_null_object)
        post :create, :photo => {:picture => mock_model(File, :content_type => "jpeg")}, :wholesaler_id => "1"
        response.should redirect_to(wholesaler_photos_path(mock_wholesaler))
      end
      
      it "should redirect to the new photo page on failure" do
        Photo.stub!(:create).and_return(mock_photo(:save => false).as_null_object)
        post :create, :photo => {:picture => mock_model(File, :content_type => "jpeg")}, :wholesaler_id => "1"
        response.should redirect_to(new_wholesaler_photo_path(mock_wholesaler))
      end

      it "should redirect to the new photo page if no photo is attached" do
        post :create, :wholesaler_id => "1"
        response.should redirect_to(new_wholesaler_photo_path(mock_wholesaler))
      end
    end

    context "zip file" do
      before do
        ZipExtractor.stub!(:new).and_return(mock_model(ZipExtractor, :extract_files => [], :cleanup => true))
        mock_wholesaler.stub!(:build_photos).and_return(3)
        @mock_picture = mock_model(File, :content_type => "application/zip", :path => "zaboomafoo")
      end

      it "should redirect to the parent wholesaler's photos" do
        post :create, :photo => {:picture => @mock_picture}, :wholesaler_id => "1"
        response.should redirect_to(wholesaler_photos_path(mock_wholesaler))
      end

      it "should pass the file path on to the ZipExtractor" do
        ZipExtractor.should_receive(:new).with("zaboomafoo")
        post :create, :photo => {:picture => @mock_picture}, :wholesaler_id => "1"
      end

      it "the wholesaler should receive a list of files to make photos from" do
        mock_wholesaler.should_receive(:build_photos).with([])
        post :create, :photo => {:picture => @mock_picture}, :wholesaler_id => "1"
      end
    end
  end
end
