{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'simple-timestamps:stamp12': => @stamp12()
    @subscriptions.add atom.commands.add 'atom-workspace',
      'simple-timestamps:stamp24': => @stamp24()

  deactivate: ->
    @subscriptions.dispose()

  stamp12: ->
    editor = atom.workspace.getActivePaneItem()
    date = new Date()
    H = date.getHours()
    M = date.getMinutes()
    S = date.getSeconds()
    p = null


    # add 0 to single-digit minutes
    if M < 10
      M = "0#{M}"

    # do the same for seconds
    if S < 10
      S = "0#{S}"

    if H < 12
      p = 'AM'
      if H is 0
        H = 12
    else
      p = 'PM'
      if H isnt 12
        H = H%12
    stamp = "#{H}:#{M}:#{S} #{p}"
    editor.insertText(stamp)

  stamp24: ->
    editor = atom.workspace.getActivePaneItem()
    date = new Date()
    H = date.getHours()
    M = date.getMinutes()
    S = date.getSeconds()

    # add 0 to single-digit minutes
    if M < 10
      M = "0#{M}"

    # do the same for seconds
    if S < 10
      S = "0#{S}"

    stamp = "#{H}:#{M}:#{S}"
    editor.insertText(stamp)
