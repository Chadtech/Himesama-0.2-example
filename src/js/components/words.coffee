# Libraries
_        = require 'lodash'
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = Words = Himesama.createClass

  needs: [ 'words', 'wordField' ]

  handle: (event) ->
    @setState wordField: event.target.value

  submit: (event) ->
    if event.which is 13
      @state.words.push event.target.value
      @setState words:      @state.words
      @setState wordField:  ''

  render: ->

    div null,

      div className:      'row',
        div className:    'column',

          input
            className:    'cell'
            value:        @state.wordField
            placeholder:  'type word, press enter'
            event:        
              input:      @handle
              keydown:    @submit

      div className:      'row',
        div className:    'column',

          p
            className:    'point'
            'Words : '

      _.map @state.words, (word, i) ->

        div className:    'row',

          p 
            className:    'point'
            i + ' ' + word
