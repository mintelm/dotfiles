import XMonad hiding ( (|||) )
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Spacing
import XMonad.Layout.SimplestFloat
import XMonad.Layout.LayoutCombinators

import qualified XMonad.StackSet as W

myTerminal    = "alacritty"
myRunMenu     = "rofi -show run -theme gruvbox.rasi -lines 7"
myModMask     = mod4Mask -- Win key
myBorderWidth = 2
myTilingRatio = 0.55
myGap         = [10, 10, 10, 10]
mySpacing     = [0, 0, 0, 0]
myWorkspaces  = ["1", "2", "3", "4"]

main = xmonad $ def {
      terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , workspaces  = withScreens 2 myWorkspaces
    , layoutHook  = myLayoutHook
    }
    `additionalKeysP` myKeybinds

myKeybinds =
    -- applications
    [ ("M-<Return>", spawn myTerminal)
    , ("M-<Space>", spawn myRunMenu)
    ]
    ++
    -- layout
    [ ("M-v", sendMessage $ JumpToLayout "Tall")
    , ("M-b", sendMessage $ JumpToLayout "Mirror Tall")
    , ("M-f", sendMessage $ JumpToLayout "SimplestFloat")
    , ("M-S-f", sendMessage $ JumpToLayout "Full")
    ]
    ++
    -- rebind workspace keybinds for IndependentScreens
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key) <- zip myWorkspaces $ map show[1..length myWorkspaces]
        , (otherModMasks, action) <- [ ("", windows . onCurrentScreen W.greedyView)
                                     , ("S-", windows . onCurrentScreen W.shift)]
    ]
    ++
    -- movement
    [ ("M-w", kill)
    ]

-- Layout Options
gap             = Border (myGap !! 0) (myGap !! 1) (myGap !! 2) (myGap !! 3)
smartGaps       = False
enableGap       = True
outerSpacing    = Border (mySpacing !! 0) (mySpacing !! 1) (mySpacing !! 2) (mySpacing !! 3)
enableSpacing   = False
uselessGaps     = spacingRaw smartGaps outerSpacing enableSpacing gap enableGap
tiled           = Tall 1 (3/100) myTilingRatio

myLayoutHook = uselessGaps (tiled ||| Mirror tiled) ||| Full ||| simplestFloat
