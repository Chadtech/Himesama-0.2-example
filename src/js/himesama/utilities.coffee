_ = require 'lodash'
{ createTextNode
  getElementById
  createElement
  querySelectorAll
  activeElement
  querySelector } = require './himesama-doc'
makeStyleString   = require './style-to-string' 

isUpperCase = (l) -> l isnt l.toLowerCase()

module.exports = Utilities = 

  htmlify: (component) ->
    if _.isString component then createTextNode component
    else
      if component.type is 'custom'
        component = component.children[0]
      output = _.reduce (_.keys component.attributes),
        (element, key) ->
          attribute = component.attributes[key]

          switch key
            when 'className'
              element.setAttribute 'class', attribute
            when 'style'
              style = makeStyleString attribute
              element.setAttribute 'style', style
            when 'event'
              _.forEach (_.keys attribute), (event) =>
                act = attribute[event]
                element.addEventListener event, act
            else
              key = _.reduce (key.split ''), (string, char) ->
                if isUpperCase char
                  char = '-' + char.toLowerCase()
                string + char
              element.setAttribute key, attribute

          element

        createElement component.type

      _.forEach component.children, (child) =>
        output.appendChild @htmlify child

      output

  getByAttribute:  (key, value) ->
    querySelector '[' + key + '="' + value + '"]'