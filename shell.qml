//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded

import QtQuick
import QtQuick.Shapes
import Quickshell
import qs.components
import qs.config
import qs.services
import qs.modules
import qs.modules.applauncher
import qs.modules.screencorners

/* why hello there!
/* to clarify: im not a good developer,
/* and things that you can see here
/* may scare or disgust you, so
/* think twice before diving here
/* bye! */

ShellRoot {
  LazyLoader {active: true; component: ScreenCorners{}}

  MainWindow {}
}
