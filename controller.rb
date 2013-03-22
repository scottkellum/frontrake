require 'compass'
require 'compass-normalize'
require 'sass-globbing'

Stasis::Options.set_template_option 'sass', { :load_paths => Compass.configuration.sass_load_paths }
Stasis::Options.set_template_option 'scss', { :load_paths => Compass.configuration.sass_load_paths }