---@diagnostic disable
local xplr = xplr
---@diagnostic enable

local vertical_layout_config = nil

local function render(ctx)
  if vertical_layout_config == nil then
    error("Vertical layout is not set up")
  end
  local cloned_config = xplr.util.clone(vertical_layout_config)
  local selection_count = #ctx.app.selection
  local maybe_helpmenu = cloned_config.splits[2]
  if selection_count == 0 then
    table.remove(cloned_config.config.constraints, 1)
    table.remove(cloned_config.splits, 1)
    if maybe_helpmenu and maybe_helpmenu == "HelpMenu" then
      cloned_config.config.constraints[1] = { Min = 1 }
    end
  else
    cloned_config.config.constraints[1] = {
      Length = selection_count
        + (cloned_config.config.vertical_margin or cloned_config.config.margin or 0)
        + 2, -- for the border
    }
    if maybe_helpmenu and maybe_helpmenu == "HelpMenu" then
      cloned_config.config.constraints[2] = { Min = 1 }
    end
  end

  -- return { CustomParagraph = { body = xplr.util.to_yaml(cloned_layout) } }
  return { CustomLayout = { Vertical = cloned_config } }
end

local function setup(config)
  config = config or {}
  config.layout = config.layout or xplr.config.layouts.builtin.default
  config.render = config.render or render

  local horizontal_layout_config = config.layout.Horizontal
  if not horizontal_layout_config then
    error("Layout does not have horizontal split")
  end

  local right_panes = horizontal_layout_config.splits[2]
  if not right_panes or not right_panes.Vertical then
    error("Right split does not have a vertical split")
  end

  local vertical_splits = right_panes.Vertical.splits
  local selection_pane = vertical_splits[1]
  if not selection_pane or selection_pane ~= "Selection" then
    error("Right vertical split does not have selection pane on top")
  end

  vertical_layout_config = right_panes.Vertical

  horizontal_layout_config.splits[2] = {
    Dynamic = "custom.zenselection.render",
  }

  xplr.fn.custom.zenselection = { render = config.render }
end

return { setup = setup }
