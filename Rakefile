require 'rb-fsevent'
require 'webrick'

include WEBrick

################################################################################################
# PUBLIC TASKS
################################################################################################

# INSTALL
# installs the gems and initialized the project
desc "installs the gems and initialized the project"
task :install do
	%x{ sudo bundle install }
	puts "Installed required gems..."
	Rake::Task['init'].invoke
end

# INIT
# initalizes the 3rd-party libraries
desc "initalizes the 3rd-party libraries"
task :init do
	%x{ cd src/assets/sass/libs && bourbon install && neat install }
	puts "Initialized 3rd-party libraries..."
end

# UPDATE
# updates the 3rd-party libraries
desc "updates the 3rd-party libraries"
task :update do
	%x{ cd src/assets/sass/libs && bourbon update && neat update }
	puts "Updated 3rd-party libraries..."
end

# REMOVE
# removes all non-source files
desc "removes all non-source files"
task :remove do
	%x{ rm -rf dist .dist_tmp .sass-cache }
	puts "Removed non-source files from project..."
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

# WATCH
# watches for changes and fires compile()
desc "watches for changes and fires compile()"
task :watch do
	puts "Watching source files for changes..."

	paths = ['src/assets/sass', 'src/assets/js', 'src/templates']
	options = { :latency => 0.75, :no_defer => true }

	fsevent = FSEvent.new
	fsevent.watch paths, options do |directories|
		puts "Detected change inside: #{directories.inspect}"
		dir = directories.inspect.to_s

		if dir.include? 'src/assets/sass'
			Rake::Task['compile_css'].execute
		elsif dir.include? 'src/assets/js'
			Rake::Task['compile_js'].execute
		elsif dir.include? 'src/templates'
			Rake::Task['compile_html'].execute
		end
	end

	fsevent.run
end

# SERVER
# runs a local webserver and watches for changes
desc "runs a local webserver and watches for changes"
multitask :server => [ :serve, :watch ]


################################################################################################
# PRIVATE TASKS
################################################################################################

# CLEAN
# cleans the dist directory
task :clean do
	%x{ rm -rf dist/.git dist/.sass-cache dist/assets/sass dist/templates }
	puts "Cleaned build directory..."
end

# CREATE
# creates the dist dir by copying src
task :create do
	%x{ cp -R src dist }
	puts "Created build directory..."
end

# SERVE
# starts the serve server
task :serve do
	Rake::Task['build'].invoke
	%x{ serve 8000 dist }
end


# COMPILE
################################################################################################

# COMPILE-CSS
# compiles sass files with compass
task :compile_css do
	%x{ compass compile }
	puts "Compiled Sass to CSS..."
end

# COMPILE-HTML
# compiles HAML to HTML
task :compile_html do
	%x{ stasis -p .dist_tmp -o src/templates }
	FileList['.dist_tmp/src/templates/**/*.html'].exclude('.dist_tmp/src/templates/partials/**/_*.html').each do |file|
		src = file
		out = file.sub(/.dist_tmp\/src\/templates/, 'dist')
		%x{ cp -f #{src} #{out} }
	end
	puts "Compiled HAML to HTML..."
end

# COMPILE-JS
# compiles coffee-script to JS
task :compile_js do
	%x{ stasis -p .dist_tmp -o src/assets/js }
	%x{ rm -rf dist/assets/js && cp -R .dist_tmp/src/assets/js dist/assets/ }
	puts "Compiled Coffee-Script to JS..."
end


# OPTIMIZE
################################################################################################

# OPTIMIZE-IMG
# shrinks image files
task :optimize_img do
	%x{ smusher dist/img }
	puts "Optimized images...."
end

# OPTIMIZE-JS
# minifies JS files
task :optimize_js do
	FileList['dist/assets/js/**/*.js'].exclude('dist/assets/js/**/*.min.js').each do |file|
		%x{ reduce -o #{file} }
	end
	puts "Optimized/minified JS assets..."
end
