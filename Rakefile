desc "installs the gems and initialized the project"
task :install do
	%x{ sudo bundle install }
	Rake::Task['init'].invoke
	puts "frontrake framework has been initialized!"
end


desc "initalizes the 3rd-party libraries"
task :init do
	%x{ cd src/assets/sass/libs && bourbon install && neat install }
	puts "Bouron and Neat libraries have been initialized!"
end


desc "updates the 3rd-party libraries"
task :update do
	%x{ cd src/assets/sass/libs && bourbon update && neat update }
	puts "Bouron and Neat libraries have been updated!"
end


desc "cleans the project's output"
task :clean do
	%x{ rm -rf ./dist }
	puts "Project files have been cleaned up!"
end


desc "compiles the asset files"
task :compile do
end


desc "builds the project files"
task :build do
end


desc "watches the source for changes"
task :watch do
end


desc "watches for changes and runs a local server"
task :server do
end