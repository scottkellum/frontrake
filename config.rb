# Require any additional compass plugins here.
require 'bootstrap-sass'

require 'compass-validator'
require 'sass-globbing'

# Project configuration
project_type = :stand_alone
#environment = :development
environment = :production

# Set this to the root of your project when deployed:
http_path = "/"

css_dir = "dist/assets/css"
sass_dir = "src/assets/sass"

images_dir = "src/img"
generated_images_dir = "dist/img"

javascripts_dir = "src/assets/js"
fonts_dir = "src/assets/fonts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :production) ? :compressed : :expanded

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false
line_comments = (environment == :production) ? :false : :true

# options passed directly to the Sass compiler
sass_options = {}

preferred_syntax = :sass
