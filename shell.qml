//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
//@ pragma IconTheme oxylite

import QtQuick
import Quickshell
import qs.modules.screencorners

/* why hello there!
/* to clarify: im not a good developer,
/* and things that you can see here
/* may scare or disgust you, so
/* think twice before diving here
/* bye! */

ShellRoot {
    LazyLoader {
        active: true
        component: ScreenCorners {}
    }

    MainWindow {}
}
