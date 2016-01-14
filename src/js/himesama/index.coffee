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

    type:       type
    attributes: args[0]
    children:   args.slice 1


Himesama = 


  Doc: require './himesama-doc'


  createClass: (c) -> 
    ->
      H = {}
      _.forEach (_.keys c), (k) ->
        v = c[k]
        v = v.bind H if _.isFunction v
        H[k] = v

      H.dirty      = false
      H.setState   = Himesama.setState.bind Himesama
      H.state      = Himesama.state
      H.type       = 'custom'
      H.attributes = arguments[0]
      H.children   = [ H.render() ]
      H


  setState: (payload) ->
    keys = _.keys payload
    _.forEach keys, (k) =>
      @state[k] = payload[k]
    @Rerender keys


  initState: (state) -> @state = state


  Render: (root, mountPoint) ->
    @VirtualDOM  = root.render()
    @allocateAddress @VirtualDOM, '.0'
    mount.appendChild @htmlify @VirtualDOM


  Rerender: (bases) ->
    _.forEach bases, (key) =>
      @markDirty @VirtualDOM, key
    @handleDirt @VirtualDOM


  handleDirt: (node) ->
    children = node.children
    if node.dirty? and node.dirty
      address = children[0].attributes[addressKey]
      element = @getByAttribute addressKey, address
      parent  = element.parentElement
      parentsAddress = parent.getAttribute addressKey
      
      element.remove()

      rendering = node.render()
      @allocateAddress rendering, parentsAddress + '.0.0'
      parent.appendChild @htmlify rendering

    else
      _.forEach children, (child) => @handleDirt child


  markDirty: (node, basis) ->
    if node.needs? and basis in node.needs
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

module.exports = _.extend Himesama, require './utilities'