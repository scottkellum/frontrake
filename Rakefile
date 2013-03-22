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
	%x{ rm -rf dist }
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

# desc "watches the source for changes"
# task :watch do
# end

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
	FileList['src/templates/**/*.html.haml'].exclude('src/templates/partials/**/*').each do |file|
		src = file
		out = file.sub(/src\/templates/, 'dist')
		out = out.sub(/html.haml/, 'html')
	end
end

# COMPILE-JS
# compiles coffee-script to JS
task :compile_js do
end


# OPTIMIZE
################################################################################################

# OPTIMIZE-IMG
# shrinks image files
task :optimize_img do
	%x{ smusher dist/img }
end
