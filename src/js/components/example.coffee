

channelWidthSensitivity = 2
cws = channelWidthSensitivity


floodFill = (targetPixel) ->

  if channelWidthCondition targetPixel

    if targetPixel.color is colorToReplace
      targetPixel.color = colorReplacement
      x = targetPixel.x
      y = targetPixel.y

      floodFill getPixel x - 1, y
      floodFill getPixel x + 1, y
      floodFill getPixel x, y - 1
      floodFill getPixel x, y + 1

channelWidthCondition = (pixel) ->
  left  = getPixel x - cws, y
  right = getPixel x + cws, y

  left  = left.color is colorToReplace 
  right = right.color is colorToReplace

  left and right



  #####################################
  ################ ################   #
  ############        ##########      #
  ##########           #####          #
  #########     ## A #########        #
  ##########   ###     #####          #
  ###############                     #
  #########                           #
  #######                             #
  ######                             ##
  ######                 X           ##
  #######                           ###
  ########                        #####
  ###########                 #########
  ##############           ############
  #################    ################
  #####################################
  #####################################

  # For the flood fill started at X,
  # at pixel A, the flood fill will stop