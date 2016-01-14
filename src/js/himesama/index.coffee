_ = require 'lodash'
{ createTextNode
  getElementById
  createElement
  querySelectorAll
  activeElement
  querySelector } = require './himesama-doc'
makeStyleString   = require './style-to-string' 

IDKey      = 'himesama-id'
addressKey = 'himesama-address'

DOMCreate = (type) ->
  ->
    args       = _.toArray arguments 
    attributes = args[0]

    type:       type
    attributes: attributes
    children:   args.slice 1


Himesama = 


  Doc: require './himesama-doc'


  createClass: (c) -> 
    ->
      args       = _.toArray arguments 
      attributes = args[0]

      # Output Himesama Component
      H = {}
      _.forEach (_.keys c), (key) ->
        if _.isFunction c[ key ]
          H[ key ] = c[ key ].bind H
        else
          H[ key ] = c[ key ]

      H.dirty      = false
      H.setState   = Himesama.setState.bind Himesama
      H.state      = Himesama.state

      H.type       = 'custom'
      H.attributes = attributes
      H.children   = [ H.render() ]
      H


  setState: (payload) ->
    keys = _.keys payload
    _.forEach keys, (key) =>
      @state[key] = payload[key]
    @Rerender keys


  initState: (state) -> @state = state


  getVirtualDOM: (root) ->
    console.log 'yee', root.type
    if root.type is 'custom'
      root.children = root.render()
    root


  Render: (root, mountPoint) ->
    @VirtualDOM  = root.render()
    @allocateAddress @VirtualDOM, '.0'
    mount.appendChild @htmlify @VirtualDOM


  Rerender: (bases) ->
    _.forEach bases, (key) =>
      @markDirty @VirtualDOM, key

    @checkForDirt @VirtualDOM


  checkForDirt: (node) ->
    if node.dirty? and node.dirty
      address = node.children[0].attributes[addressKey]
      element = @getByAttribute addressKey, address
      parent  = element.parentElement
      parentsAddress = parent.getAttribute addressKey
      
      element.remove()

      rendering = node.render()
      @allocateAddress rendering, parentsAddress + '.0.0'
      parent.appendChild @htmlify rendering

    else
      _.forEach node.children, (child) =>
        @checkForDirt child


  markDirty: (node, basis) ->
    if node.type is 'custom'
      if node.needs?
        if basis in node.needs
          node.dirty = true
    _.forEach node.children, (child, ci) =>
      @markDirty child, basis


  allocateAddress: (node, address) ->
    unless _.isString node 
      if node.type isnt 'custom'
        node.attributes = {} if node.attributes is null
        node.attributes[addressKey] = address

    _.forEach node.children, (child, ci) =>
      @allocateAddress child, address + '.' + ci


  DOM:
    p:     DOMCreate 'p'
    div:   DOMCreate 'div'
    input: DOMCreate 'input'



Himesama.Render     = Himesama.Render.bind Himesama
Himesama.initState  = Himesama.initState.bind Himesama

module.exports = _.extend Himesama, (require './utilities')