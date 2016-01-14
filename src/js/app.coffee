# Libraries
Himesama              = require './himesama'
{ Doc, DOM }          = Himesama
{ Render, initState } = Himesama
{ getElementById }    = Doc

# DOM
{ p, div, input } = DOM

# Components
Title      = require './components/title'
TitleField = require './components/title-field'
Count      = require './components/count'
Increment  = require './components/increment'
Decrement  = require './components/decrement'
Words      = require './components/words'

# State
initState 
  count:        0
  wordField:    ''
  words:        [ ]
  catchPhrase:  'Lets make websites sempai'



App = Himesama.createClass

  coolNumber: 14

  render: -> 

    div null,
      div className:        'container',
        div className:      'row',
          Title() 

        div className:      'row',
          div className:    'column'

        div className:      'row',
          div className:    'column',
            TitleField()

        div className:      'row',
          div className:    'column wide',
            Count()

        div className:      'row',
          div className:    'column',
            Increment()
          div className:    'column',
            Decrement()

        Words()


Render App(), getElementById 'mount'
