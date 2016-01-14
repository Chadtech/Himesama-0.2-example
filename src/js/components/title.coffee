# Libraries
Himesama = require '../himesama'
{ DOM }  = Himesama

# DOM
{ p, div, input } = DOM


module.exports = Title = Himesama.createClass

  needs: [ 'catchPhrase' ]

  render: ->
    
    title =  'Himesama !! : '
    title += @state.catchPhrase

    p
      className: 'point'
      title
