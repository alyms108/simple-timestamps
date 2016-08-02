# 'use babel';
#
# import SimpleTimestampsView from './simple-timestamps-view';
# import { CompositeDisposable } from 'atom';
#
# export default {
#
#   simpleTimestampsView: null,
#   modalPanel: null,
#   subscriptions: null,
#
#   activate(state) {
#     this.simpleTimestampsView = new SimpleTimestampsView(state.simpleTimestampsViewState);
#     this.modalPanel = atom.workspace.addModalPanel({
#       item: this.simpleTimestampsView.getElement(),
#       visible: false
#     });
#
#     // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
#     this.subscriptions = new CompositeDisposable();
#
#     // Register command that toggles this view
#     this.subscriptions.add(atom.commands.add('atom-workspace', {
#       'simple-timestamps:toggle': () => this.toggle()
#     }));
#   },
#
#   deactivate() {
#     this.modalPanel.destroy();
#     this.subscriptions.dispose();
#     this.simpleTimestampsView.destroy();
#   },
#
#   serialize() {
#     return {
#       simpleTimestampsViewState: this.simpleTimestampsView.serialize()
#     };
#   },
#
#   toggle() {
#     console.log('SimpleTimestamps was toggled!');
#     return (
#       this.modalPanel.isVisible() ?
#       this.modalPanel.hide() :
#       this.modalPanel.show()
#     );
#   }
#
# };

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

  # convert: ->
  #   console.log 'Convert text!'

  stamp12: ->
    # console.log '12-hour format!'
    # editor = atom.workspace.getActivePaneItem()
    editor = atom.workspace.getActiveTextEditor()
    date = new Date()
    H = date.getHours()
    M = date.getMinutes()
    S = date.getSeconds()
    p = null

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
    # console.log '24-hour format!'
    editor = atom.workspace.getActivePaneItem()
    date = new Date()
    H = date.getHours()
    M = date.getMinutes()
    S = date.getSeconds()
    stamp = "#{H}:#{M}:#{S}"
    editor.insertText(stamp)
