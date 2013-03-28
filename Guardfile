# More info at https://github.com/guard/guard#readme

# guard-compass
guard 'compass' do
	watch(%r{^src/assets/sass/(.+\.s[ac]ss)$})
end

# guard-coffeescript
guard 'coffeescript', :input => 'src/assets/js', :output => 'dist/assets/js'

# guard-erb
guard 'erb', :input => 'src/templates/index.html.erb', :output => "dist/index.html" do
	watch (%r{src/templates/index.html.erb})
end


# guard-jammit
guard :jammit, :config_path => 'assets.yml' do
	watch(%r{^dist/assets/css/(.*)\.css$})
	watch(%r{^dist/assets/js/(.*)\.js$})
end


# guard-webrick
guard 'webrick', :host => '127.0.0.1', :port => '8008', :docroot => 'dist' do
end

# guard-livereload
guard 'livereload', :grace_period => 0.75 do
	watch(%r{^dist/assets/css/(.+\.css)$})
	watch(%r{^dist/assets/js/(.+\.js)$})
end
