require 'fileutils'
require 'colorize'

require 'rb-fsevent'
require 'piet'


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
end

# UPDATE
# updates the 3rd-party libraries
desc "updates the 3rd-party libraries"
task :update do
	Dir.chdir "src/assets/sass/libs"
	system("bourbon update")
end

# REMOVE
# removes all non-source files
desc "removes all non-source files"
task :remove do
	FileUtils.rm_rf "public"
	FileUtils.rm_rf ".public"
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
	Rake::Task['optimize_css'].invoke
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

# SERVER
# runs a local webserver and watches for changes
desc "runs a local webserver and watches for changes"
task :server do
	Rake::Task['build'].invoke
	system("guard start --no-bundler-warning")
end

# PACK
# packages the current build
desc "packages the current build"
task :pack do
	date = Time.now
	date = date.strftime("%Y-%m-%d_%H-%M")

	if File.directory? "public"
		unless File.directory? "packs"
			FileUtils.mkdir "packs"
		end
		system("tar -zcf packs/#{date}.tar.gz public")
		puts "Created archive at packs/#{date}.tar.gz".colorize( :color => :green )
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
	FileUtils.rm_rf "public/.git"
	FileUtils.rm_rf "public/.sass-cache"
	FileUtils.rm_rf "public/assets/sass"
	FileUtils.rm_rf "public/templates"
	FileUtils.rm_rf ".public"
	FileUtils.rm_rf ".sass-cache"
	puts "Cleaned build directory...".colorize( :color => :green )
end

# CREATE
# creates the dist dir by copying src
task :create do
	files = Dir.glob("src/*")
	FileUtils.mkdir "public"
	FileUtils.cp_r files, "public"
	FileUtils.cp "src/.htaccess", "public/.htaccess"
	puts "Created build directory...".colorize( :color => :green )
end


# COMPILE
################################################################################################

# COMPILE-CSS
# compiles sass files with compass
task :compile_css do
	system("compass compile")
	puts "Compiled Sass to CSS...".colorize( :color => :green )
end

# COMPILE-HTML
# compiles ERB to HTML
task :compile_html do
	%x{stasis -p .public -o src/templates}
	FileList['.public/src/templates/**/*.html'].exclude('.public/src/templates/partials/**/_*.html').each do |file|
		src = file
		out = file.sub(/.public\/src\/templates/, 'public')
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
	%x{stasis -p .public -o src/assets/js}
	FileUtils.rm_rf "public/assets/js"
	FileUtils.cp_r ".public/src/assets/js", "public/assets"
	puts "Compiled Coffee-Script to JS...".colorize( :color => :green )
end


# OPTIMIZE
################################################################################################

# OPTIMIZE-CSS
# minifies CSS files
task :optimize_css do
	FileList['public/assets/css/**/*.css'].exclude('public/assets/css/**/*.min.css').each do |file|
		system("reduce -o #{file}")
	end
	puts "Optimized/minified CSS assets...".colorize( :color => :green )
end

# OPTIMIZE-IMG
# shrinks image files
task :optimize_img do
	FileList['public/img/*'].each do |img|
		Piet.optimize(img)
	end
	puts "Optimized images....".colorize( :color => :green )
end

# OPTIMIZE-JS
# minifies JS files
task :optimize_js do
	FileList['public/assets/js/**/*.js'].exclude('public/assets/js/**/*.min.js').each do |file|
		system("reduce -o #{file}")
	end
	puts "Optimized/minified JS assets...".colorize( :color => :green )
end