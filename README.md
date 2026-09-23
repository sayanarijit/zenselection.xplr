# zenselection

Hide the selection pane or dynamically adjust its length as you select paths.

This plugin works with the default layout config. If you use a custom layout, you will need to pass the layout object explicitely.

To make it work with other UI/Layout modifying plugins, you must require this plugin before them in your `~/.config/xplr/init.lua` file.

[![demo](https://s15.gifyu.com/images/buAow.gif)](https://gifyu.com/image/buAow)

## Installation

### Manual Steps

- Add the following line in ~/.config/xplr/init.lua

```lua
local home = os.getenv("HOME")
package.path = home
.. "/.config/xplr/plugins/?/init.lua;"
.. home
.. "/.config/xplr/plugins/?.lua;"
.. package.path
```

- Clone the plugin

```bash
git clone https://github.com/sayanarijit/zenselection.xplr ~/.config/xplr/plugins/zenselection
```

- Require the module in `~/.config/xplr/init.lua`

```lua
-- Must be setup before other UI/Layout modifying plugins
require("zenselection").setup()
```

### Using [xpm.xplr](https://github.com/dtomvan/xpm.xplr)

```lua
require("xpm").setup({
    -- Must be added before other UI/Layout modifying plugins
    "sayanarijit/zenselection.xplr",
    -- ...
})
```

## Also See

You can use this plugin alongside the following plugins to enhance your experience:

- [zentable.xplr](https://github.com/sayanarijit/zentable.xplr)
- [treeview.xplr](https://github.com/sayanarijit/tree-view.xplr)
- [dual-pane.xplr](https://github.com/sayanarijit/dual-pane.xplr)
- [tri-pane.xplr](https://github.com/sayanarijit/tri-pane.xplr)
