# roots v2.1.2
# Files in this list will not be compiled - minimatch supported
ignore_files: ['_*', 'readme*', '.gitignore', '.DS_Store']
ignore_folders: ['.git']

# Layout file config
# `default` applies to all views. Override for specific
# views as seen below.
layouts:
  default: 'layout.jade'

watcher_ignore_folders: ['components']

locals:
  title: 'Welcome to Roots!'
  title_with_markup: ->
    "<h1 class='title'>Welcome to Roots!</h1>"
