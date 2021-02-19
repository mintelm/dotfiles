import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens
import qualified XMonad.StackSet as W

myTerminal    = "alacritty"
myModMask     = mod4Mask -- Win key
myBorderWidth = 2
myWorkspaces  = ["1", "2", "3", "4"]

main = xmonad $ def {
      terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , workspaces  = withScreens 2 myWorkspaces
    }
    `additionalKeysP` myKeybinds

myKeybinds =
    -- applications
    [ ("M-<Return>", spawn myTerminal)
    , ("M-<Space>", spawn "rofi -show run -theme gruvbox.rasi -lines 7")
    ]
    ++
    -- layout
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key) <- zip myWorkspaces $ map show[1..length myWorkspaces]
        , (otherModMasks, action) <- [ ("", windows . onCurrentScreen W.greedyView)
                                     , ("S-", windows . onCurrentScreen W.shift)]
    ]
    ++
    -- movement
    [ ("M-w", kill)
    ]
