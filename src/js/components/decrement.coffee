# Libraries
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = Decrement = Himesama.createClass

  handle: ->
    @setState counter: (@state.counter - 1)

  render: ->
    input
      className:  'nullButton'
      type:       'submit'
      value:      '-'
      event:
        click:    @handle

