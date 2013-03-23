# frontrake

A rapid development framework built upon Compass; Rake powered!

---

`frontrake` is a frontend framework with built in tasks like other tools provide, such as `Yeoman`, `GruntJS` and others players around. It aims to help frontend developers with their workflow by providing a handful of smart `Rake` tasks.

Note: The code may be worse than bad - but I'm not a developer. Since everything works, it can't be thaaat ugly.

## Features

Features can be splitted into two divisions: One for the framework & one for the provided `Rake` tasks.

### Framework

- **Coffee-Script Support**    
  write better JS with `coffee-script`
- **SASS/SCSS Support**    
  `frontrake` is built upon `Compass` and therefor fully compatible with `SASS`
- **HAML Support**    
  we use pre-processors for CSS & JS - let's use one for HTML as well
- **Rake Powered**    
  everything can be run through `Rake` tasks, making it stupid easy to get started
- and more…

### Rake

- **LiveReload**    
  reloads the browser every time a (source) file has changed
- **Server**    
  built-in web server for painless developing
- **Watch**    
  watches the directory for changes and compiles on event


## Install

Installation is easy. Clone the repository, `cd` to it's location and run:

    sudo bundle install

## Tasks

To get a list of all available tasks, run `rake -T`:

    rake build     # builds the project files
    rake compile   # compiles the source files
    rake init      # initalizes the 3rd-party libraries
    rake optimize  # optimizes static asset files
    rake pack      # packages the current build
    rake remove    # removes all non-source files
    rake server    # runs a local webserver and watches for changes
    rake update    # updates the 3rd-party libraries
    rake watch     # watches for changes and fires compile()

## Structure

For the moment you have to stick with _my_ folder structure, e.g. it's basics:

    / - project root
    -- /src - source root
    ---- /assets - assets directory
    ------ /sass - SASS/CSS root
    ------ /js - coffee-script/js root
    ---- /templates - HAML/HTML root
    
    -- /dist - output directory
    -- /packs - archive/backup directory