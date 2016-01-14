# Libraries
Himesama      = require './himesama'
{ Doc, DOM }          = Himesama
{ Render, initState } = Himesama
{ createTextNode
  getElementById
  createElement
  querySelectorAll
  activeElement
  querySelector } = Doc

# DOM
{ p, div, input } = DOM

# Components
Count     = require './components/count'
Increment = require './components/increment'
Decrement = require './components/decrement'

# State
initState count: 0


App = Himesama.createClass

  coolNumber: 14

  render: -> 
    # console.log 'A'
    div null,
      div className:        'container',
        div className:      'row',
          p
            className:    'point'
            coolNumber:   @coolNumber
            'Himesama !!'

        div className:      'row',
          div className:    'column',
            Count()

        div className:      'row',
          div className:    'column',
            Increment()
          div className:    'column',
            Decrement()



Render App(), getElementById 'mount'
