platform = RUBY_PLATFORM
if platform.include?("64-linux")
  WickedPdf.config = {:exe_path => Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s}
else
  WickedPdf.config = { :wkhtmltopdf => "/Users/Cory/.rvm/gems/ruby-2.1.1/bin/wkhtmltopdf", :exe_path => '/usr/local/bin/wkhtmltopdf'}
end