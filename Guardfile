# More info at https://github.com/guard/guard#readme

# guard-compass
guard 'compass' do
	watch(%r{^src/assets/sass/(.+\.s[ac]ss)$})
end

# guard-coffeescript
guard 'coffeescript', :input => 'src/assets/js', :output => 'public/assets/js'

# guard-jammit
guard :jammit, :config_path => 'assets.yml' do
	watch(%r{^public/assets/css/(.*)\.css$})
	watch(%r{^public/assets/js/(.*)\.js$})
end

# guard-webrick
guard 'webrick', :host => '127.0.0.1', :port => '8008', :docroot => 'public' do
end

# guard-livereload
guard 'livereload', :grace_period => 0.25 do
	watch(%r{^public/assets/css/(.+\.css)$})
	watch(%r{^public/(.+\.html)$})
	watch(%r{^public/assets/js/(.+\.js)$})
	watch(%r{^public/img/(.+\.png)$})
	watch(%r{^public/img/(.+\.gif)$})
	watch(%r{^public/img/(.+\.jpg)$})
end

# guard-shell
guard 'shell' do
	watch(%r{^src/templates/(.+\.erb)$}) { |m|
		`stasis -o src/templates -p .public`
		`cp .public/src/templates/*.html public/`
		`echo #{m[0]} updated`
	}
end

guard :shell do
	watch(%r{^public/(.+\.*)$}) { |m|
		`terminal-notifier-success -title "frontrake" -subtitle "Guard Notification" -message "#{m[0]} has changed"`
	}
end