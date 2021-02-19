import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W

myTerminal    = "alacritty"
myRunMenu     = "rofi -show run -theme gruvbox.rasi -lines 7"
myModMask     = mod4Mask -- Win key
myBorderWidth = 2
myGapWidth    = 10
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
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key) <- zip myWorkspaces $ map show[1..length myWorkspaces]
        , (otherModMasks, action) <- [ ("", windows . onCurrentScreen W.greedyView)
                                     , ("S-", windows . onCurrentScreen W.shift)]
    ]
    ++
    -- movement
    [ ("M-w", kill)
    ]

myLayoutHook =
    spacingRaw False (Border 0 0 0 0) False(Border myGapWidth myGapWidth myGapWidth myGapWidth) True $ layoutHook def
