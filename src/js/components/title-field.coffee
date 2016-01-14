# Libraries
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = TitleField = Himesama.createClass
  
  needs: [ 'catchPhrase' ]

  handle: (event) ->
    @setState catchPhrase: event.target.value

  render: ->

    input
      className:    'cell'
      value:        @state.catchPhrase
      placeholder:  'enter a catch phrase'
      event:        input: @handle