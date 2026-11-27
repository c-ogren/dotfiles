--------------------------------------------------
-- Laptop only (XPS 15 9560, Intel HD 630)
--------------------------------------------------
-- hyprland.lua loads this on machines with a battery. appearance.lua already
-- keeps effects off for this iGPU, so only laptop-specific settings go here.

-- Allocate buffers without explicit format modifiers. In this config since
-- the start; on the desktop's RTX 5070 it made Hyprland abort at startup.
hl.env("AQ_NO_MODIFIERS", "1")
