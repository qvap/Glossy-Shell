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

ShellRoot {
  LazyLoader {active: true; component: ScreenCorners{}}
  MainWindow {}
  Bar {}
}
