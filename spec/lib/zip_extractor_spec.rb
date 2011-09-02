require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ZipExtractor do
  before do
    @zip_path = RAILS_ROOT + "/spec/fixtures/"
  end

  it "should tell what directory it's unpacking to" do 
    z = ZipExtractor.new(@zip_path + "one_image.zip")
    z.base_path.should == RAILS_ROOT + "/tmp/photos/#{z.hash}"
  end

  it "should extract a single file into tmp" do
    z = ZipExtractor.new(@zip_path + "one_image.zip")
    files = z.extract_files(["jpg"])
    files.first.path.should == "#{z.base_path}/test_image.jpg"
  end

  it "should extract two files into tmp" do
    z = ZipExtractor.new(@zip_path + "two_images.zip")
    files = z.extract_files(["jpg"])
    files.collect(&:path).sort.should == ["#{z.base_path}/test_image.jpg","#{z.base_path}/test_image2.jpg"]
  end

  it "should extract nested files in various subdirectories" do
    z = ZipExtractor.new(@zip_path + "images_in_folders.zip")
    files = z.extract_files(["jpg"])
    files.collect(&:path).sort.should == ["#{z.base_path}/subfolder/test_image2.jpg", "#{z.base_path}/subfolder/test_image3.jpg","#{z.base_path}/test_image.jpg"]
  end
 
  it "should return nothing if no files of a requested type are found" do
    z = ZipExtractor.new(@zip_path + "images_in_folders.zip")
    files = z.extract_files(["mov"])
    files.should be_empty
  end

  it "should return files of different types if multiple types are requested" do
    z = ZipExtractor.new(@zip_path + "many_types.zip")
    files = z.extract_files(["jpg", "jpeg"])
    files.collect(&:path).sort.should == ["#{z.base_path}/test_image.jpeg", "#{z.base_path}/test_image.jpg"]
  end

  it "should ignore case on the file types" do
    z = ZipExtractor.new(@zip_path + "case_sensitive.zip")
    files = z.extract_files(["jpg"])
    files.first.path.should == "#{z.base_path}/test_case_image.Jpg"
  end

  it "should clean up after itself" do
    z = ZipExtractor.new(@zip_path + "case_sensitive.zip")
    files = z.extract_files(["jpg"])
    z.cleanup
    File.exists?(z.base_path).should be_false
  end
end
