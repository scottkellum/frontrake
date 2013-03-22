require 'rb-fsevent'

################################################################################################
# PUBLIC TASKS
################################################################################################

# INSTALL
# installs the gems and initialized the project
desc "installs the gems and initialized the project"
task :install do
	%x{ sudo bundle install }
	Rake::Task['init'].invoke
end

# INIT
# initalizes the 3rd-party libraries
desc "initalizes the 3rd-party libraries"
task :init do
	%x{ cd src/assets/sass/libs && bourbon install && neat install }
end

# UPDATE
# updates the 3rd-party libraries
desc "updates the 3rd-party libraries"
task :update do
	%x{ cd src/assets/sass/libs && bourbon update && neat update }
end

# REMOVE
# removes the dist directory
desc "removes the dist directory"
task :remove do
	%x{ rm -rf dist .dist_tmp }
end

# COMPILE
# compiles the source files
desc "compiles the source files"
task :compile do
	Rake::Task['compile_css'].invoke
	Rake::Task['compile_html'].invoke
	Rake::Task['compile_js'].invoke
end

# OPTIMIZE
# optimizes static asset files
desc "optimizes static asset files"
task :optimize do
	Rake::Task['optimize_img'].invoke
	Rake::Task['optimize_js'].invoke
end

# BUILD
# builds the project files
desc "builds the project files"
task :build do
	Rake::Task['remove'].invoke
	Rake::Task['create'].invoke
	Rake::Task['compile'].invoke
	Rake::Task['optimize'].invoke
	Rake::Task['clean'].invoke
end

desc "watches the source for changes"
task :watch do
	paths = ['src']
	options = {:latency => 0.75, :no_defer => true }

	fsevent = FSEvent.new
	fsevent.watch paths, options do |directories|
		puts "Detected change inside: #{directories.inspect}"

		dir = directories.inspect.to_s.sub(/#{Dir.pwd}/, '')
		if dir == "/src/assets/sass"
			Rake::Task['compile_css'].invoke
		elsif dir == "/src/assets/js"
			Rake::Task['compile_js'].invoke
		elsif dir == "/src/templates"
			Rake::Task['compile_html'].invoke
		end
	end

	fsevent.run
end

# desc "watches for changes and runs a local server"
# task :server do
# end


################################################################################################
# PRIVATE TASKS
################################################################################################

# CLEAN
# cleans the dist directory
task :clean do
	%x{ rm -rf dist/.git dist/.sass-cache dist/assets/sass dist/templates }
end

# CREATE
# creates the dist dir by copying src
task :create do
	%x{ cp -R src dist }
end


# COMPILE
################################################################################################

# COMPILE-CSS
# compiles sass files with compass
task :compile_css do
	%x{ compass compile }
end

# COMPILE-HTML
# compiles HAML to HTML
task :compile_html do
	%x{ stasis -p .dist_tmp -o src/assets/js,src/templates }
	FileList['.dist_tmp/src/templates/**/*.html'].exclude('.dist_tmp/src/templates/partials/**/_*.html').each do |file|
		src = file
		out = file.sub(/.dist_tmp\/src\/templates/, 'dist')
		%x{ cp #{src} #{out} }
	end
end

# COMPILE-JS
# compiles coffee-script to JS
task :compile_js do
	%x{ stasis -p .dist_tmp -o src/assets/js,src/templates }
	%x{ rm -rf dist/assets/js && cp -R .dist_tmp/src/assets/js dist/assets/ }
end


# OPTIMIZE
################################################################################################

# OPTIMIZE-IMG
# shrinks image files
task :optimize_img do
	%x{ smusher dist/img }
end

# OPTIMIZE-JS
# minifies JS files
task :optimize_js do
	FileList['dist/assets/js/**/*.js'].exclude('dist/assets/js/**/*.min.js').each do |file|
		%x{ reduce -o #{file} }
	end
end
