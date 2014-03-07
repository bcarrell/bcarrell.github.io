jeet = module.require('jeet')

module.exports =
  ignore_files: ['_*', 'readme*', '.gitignore', '.DS_Store']
  ignore_folders: ['.git']

  layouts:
    default: 'layout.jade'

  watcher_ignore_folders: ['components']

  locals:
    title: 'Welcome to Roots!'
    title_with_markup: ->
      "<h1 class='title'>Welcome to Roots!</h1>"

  stylus:
    plugins: [
      jeet
      'axis-css'
    ]
