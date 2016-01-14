# Libraries
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = Decrement = Himesama.createClass

  handle: ->
    @setState count: @state.count - 1

  render: ->
    input
      className:  'nullButton'
      type:       'submit'
      value:      '-'
      event:      click: @handle

