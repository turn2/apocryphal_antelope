require 'zip/zip'
class ZipExtractor

  def initialize(zipfile)
    @zipfile = zipfile
  end
 
  def base_path
    RAILS_ROOT + "/tmp/photos/#{self.object_id}"
  end

  def extract_files(file_extensions)
    returning Array.new do |file_list|
      unzip_file
      Dir.glob(fake_case_insensitivity(file_extensions).map { | extension | base_path + "/**/*." + extension }).each do |file|
        file_list << File.open(file)
      end
    end
  end

  def cleanup
    FileUtils.rm_r(base_path)
  end

  private

  def unzip_file 
    Zip::ZipFile.open(@zipfile) do |zip_file|
      zip_file.each do |file|
        file_path = File.join(base_path, file.name)
        FileUtils.mkdir_p(File.dirname(file_path))
        zip_file.extract(file, file_path) unless File.exist?(file_path)
      end
    end
  end

  def fake_case_insensitivity(extensions)
    extensions.map { |ext| [ext.downcase, ext.upcase, ext.capitalize] }.flatten
  end
  
end
