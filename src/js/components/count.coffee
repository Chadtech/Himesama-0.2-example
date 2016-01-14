# Libraries
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = Count = Himesama.createClass

  needs: [ 'count' ]

  render: ->
    p
      className: 'point'
      '' + @state.count

