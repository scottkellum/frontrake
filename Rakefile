require 'fileutils'
require 'colorize'

require 'os'
if OS.windows?
	require 'rb-fchange'
elsif OS.osx?
	require 'rb-fsevent'
	require 'piet'
elsif OS.posix?
	require 'rb-inotify'
	require 'piet'
end


task :default => [:server]


################################################################################################
# PUBLIC TASKS
################################################################################################

# INIT
# initalizes the 3rd-party libraries
desc "initalizes the 3rd-party libraries"
task :init do
	Dir.chdir "src/assets/sass/libs"
	system("bourbon install")
	system("neat install")
	#puts "Initialized 3rd-party libraries..."
end

# UPDATE
# updates the 3rd-party libraries
desc "updates the 3rd-party libraries"
task :update do
	Dir.chdir "src/assets/sass/libs"
	system("bourbon update")
	system("neat update")
	#puts "Updated 3rd-party libraries..."
end

# REMOVE
# removes all non-source files
desc "removes all non-source files"
task :remove do
	FileUtils.rm_rf "dist"
	FileUtils.rm_rf ".dist_tmp"
	FileUtils.rm_rf ".sass-cache"
	puts "Removed non-source files from project...".colorize( :color => :green )
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
	puts "Watching source files for changes...".colorize( :color => :light_blue )

	if OS.windows?
		Rake::Task['watch_windows'].execute
	elsif OS.osx?
		Rake::Task['watch_osx'].execute
	elsif OS.posix?
		Rake::Task['watch_linux'].execute
	end
end

# SERVER
# runs a local webserver and watches for changes
desc "runs a local webserver and watches for changes"
multitask :server => [ :serve, :watch, :guard ]

# PACK
# packages the current build
desc "packages the current build"
task :pack do
	date = Time.now
	date = date.strftime("%Y-%m-%d_%H-%M")

	if File.directory? "dist"
		unless File.directory? "packs"
			FileUtils.mkdir "packs"
		end
		system("tar -zcf packs/#{date}.tar.gz dist")
	else
		puts "Not created. Dist directory doesn't exist...".colorize( :color => :yellow )
	end
end


################################################################################################
# PRIVATE TASKS
################################################################################################

# CLEAN
# cleans the dist directory
task :clean do
	FileUtils.rm_rf "dist/.git"
	FileUtils.rm_rf "dist/.sass-cache"
	FileUtils.rm_rf "dist/assets/sass"
	FileUtils.rm_rf "dist/templates"
	puts "Cleaned build directory...".colorize( :color => :green )
end

# CREATE
# creates the dist dir by copying src
task :create do
	files = Dir.glob("src/*")
	FileUtils.mkdir "dist"
	FileUtils.cp_r files, "dist"
	puts "Created build directory...".colorize( :color => :green )
end

# SERVE
# starts the serve server
task :serve do
	Rake::Task['build'].invoke
	puts "Starting Serve web server...".colorize( :color => :light_blue )
	puts "\n"
	puts "####################################################".colorize( :background => :light_blue )
	puts "  Serve can be access via: http://127.0.0.1:8000    ".colorize( :background => :light_blue )
	puts "####################################################".colorize( :background => :light_blue )
	puts "\n"
	%x{serve 8000 dist}
end

# GUARD
# starts Guards (LiveReload)
task :guard do
	puts "Starting Guard LiveReload....".colorize( :color => :light_blue )
	%x{guard start --no-bundler-warning --notify false}
end


# COMPILE
################################################################################################

# COMPILE-CSS
# compiles sass files with compass
task :compile_css do
	%x{compass compile}
	puts "Compiled Sass to CSS...".colorize( :color => :green )
end

# COMPILE-HTML
# compiles HAML to HTML
task :compile_html do
	%x{stasis -p .dist_tmp -o src/templates}
	FileList['.dist_tmp/src/templates/**/*.html'].exclude('.dist_tmp/src/templates/partials/**/_*.html').each do |file|
		src = file
		out = file.sub(/.dist_tmp\/src\/templates/, 'dist')
		if File.exist? out
			FileUtils.rm out
		end
		FileUtils.cp src, out
	end
	puts "Compiled ERB to HTML...".colorize( :color => :green )
end

# COMPILE-JS
# compiles coffee-script to JS
task :compile_js do
	%x{stasis -p .dist_tmp -o src/assets/js}
	FileUtils.rm_rf "dist/assets/js"
	FileUtils.cp_r ".dist_tmp/src/assets/js", "dist/assets"
	puts "Compiled Coffee-Script to JS...".colorize( :color => :green )
end


# OPTIMIZE
################################################################################################

# OPTIMIZE-IMG
# shrinks image files
task :optimize_img do
	FileList['dist/img/*'].each do |img|
		if OS.windows?
			system("smusher dist/img")
		else
			Piet.optimize(img)
		end
	end
	puts "Optimized images....".colorize( :color => :green )
end

# OPTIMIZE-JS
# minifies JS files
task :optimize_js do
	FileList['dist/assets/js/**/*.js'].exclude('dist/assets/js/**/*.min.js').each do |file|
		system("reduce -o #{file}")
	end
	puts "Optimized/minified JS assets...".colorize( :color => :green )
end


# WATCH
################################################################################################

# WATCH-WINDOWS
# watches for changes on windows plattforms
task :watch_windows do
	notifier = FChange::Notifier.new

  	notifier.watch("src/assets/sass", :all_events, :recursive) do |event|
    	Rake::Task['compile_css'].execute
  	end
  	notifier.watch("src/assets/js", :all_events, :recursive) do |event|
    	Rake::Task['compile_js'].execute
  	end
  	notifier.watch("src/templates", :all_events, :recursive) do |event|
    	Rake::Task['compile_html'].execute
  	end

  	Signal.trap('INT') do
	    notifier.stop
	end

  	notifier.run
end

# WATCH-OSX
# watches for changes on osx plattforms
task :watch_osx do
	paths = ['src/assets/sass', 'src/assets/js', 'src/templates']
	options = { :latency => 0.75, :no_defer => true }

	notifier = FSEvent.new
	notifier.watch paths, options do |directories|
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

	notifier.run
end

# WATCH-LINUX
# watches for changes on linux plattforms
task :watch_linux do
	notifier = INotify::Notifier.new

	notifier.watch("src/assets/sass", :modify, :moved_to, :create, :delete)
		Rake::Task['compile_css'].execute
	notifier.watch("src/assets/js", :modify, :moved_to, :create, :delete)
		Rake::Task['compile_js'].execute
	notifier.watch("src/templates", :modify, :moved_to, :create, :delete)
		Rake::Task['compile_html'].execute

	notifier.run
end
