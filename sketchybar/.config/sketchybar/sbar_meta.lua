---@meta

---@alias SBoolean true | false | 1 | 0 | "yes" | "no" | "on" | "off"
---                     | "toggle" Inverts current boolean value
---@alias SInt number
---@alias SPositiveInt number
---@alias SARGBHex string | number

---@class BarProperties
---@field color          SARGBHex?                           Color of the bar
---@field border_color   SARGBHex?                           Color of the bars border
---@field position       ("top" | "bottom")?                 Position of the bar on the screen
---@field height         SInt?                               Height of the bar
---@field margin         SInt?                               Margin around the bar
---@field y_offset       SInt?                               Vertical offset of the bar from its default position
---@field corner_radius  SPositiveInt?                       Corner radius of the bar
---@field border_width   SPositiveInt?                       Border width of the bars border
---@field blur_radius    SPositiveInt?                       Blur radius applied to the background of the bar
---@field padding_left   SPositiveInt?                       Padding between the left bar border and the leftmost item
---@field padding_right  SPositiveInt?                       Padding between the right bar border and the rightmost item
---@field notch_width    SPositiveInt?                       The width of the notch to be accounted for on the internal display
---@field notch_offset   SPositiveInt?                       Additional y_offset exclusively applied to notched screens
---@field display        ("main" | "all" | SPositiveInt[])?  Display to show the bar on
---@field hidden         (SBoolean | "current")?             If all / the current bar is hidden
---@field topmost        (SBoolean | "window")?              If the bar should be drawn on top of everything, or on top of all windows
---@field sticky         SBoolean?                           Makes the bar sticky during space changes
---@field font_smoothing SBoolean?                           If fonts should be smoothened
---@field shadow         SBoolean?                           If the bar should draw a shadow

---@class ItemProperties
---@field drawing            SBoolean?                       If the item should be drawn into the bar
---@field position           ("left" | "right" | "center")?  Position of the item in the bar
---@field space              SPositiveInt[]?                 Spaces to show this item on
---@field display            (SPositiveInt[] | "active")?    Displays to show this item on
---@field ignore_association SBoolean?                       Ignores all space / display associations while on
---@field y_offset           SInt?                           Vertical offset applied to the item
---@field padding_left       SInt?                           The padding applied left of the item
---@field padding_right      SInt?                           The padding applied right of the item
---@field width              (SPositiveInt | "dynamic")?     Makes the item use a fixed width given in points
---@field scroll_texts       SBoolean?                       Controls the automatic scroll of all items texts, which are truncated by the max_chars property
---@field blur_radius        SPositiveInt?                   The blur radius applied to the background of the item
---
---@field icon               (string | TextProperties)?
---@field label              TextProperties?
---@field background         BackgroundProperties?
---
---@field script             string?
---@field click_script       string?
---@field update_freq        SPositiveInt?
---@field updates            (SBoolean | "when_shown")?
---@field mach_helper        string?

---@class TextProperties
---@field string          string?                         Sets the text to the specified string
---@field drawing         SBoolean?                       If the text is rendered
---@field highlight       SBoolean?                       If the text uses the highlight_color or the regular color
---@field color           SARGBHex?                       Color used to render the text
---@field highlight_color SARGBHex?                       Highlight color of the text (e.g. for active space icon
---@field padding_left    SInt?                           Padding to the left of the text
---@field padding_right   SInt?                           Padding to the right of the text
---@field y_offset        SInt?                           Vertical offset applied to the text
---@field font            string?                         The font to be used for the text in the form "<family>:<type>:<size>"
---@field font.size       number?                         The font size to be used for the text
---@field scroll_duration SPositiveInt?                   Sets the scroll speed of text trucated by max_chars on items with scroll_texts enabled
---@field max_chars       SPositiveInt?                   Sets the maximum characters to display (can be scrolled via the items scroll_texts property)
---@field width           (SPositiveInt | "dynamic")?     Makes the text use a fixed width given in points
---@field align           ("center" | "left" | "right")?  Aligns the text in its container when it has a fixed width larger than the content width
---@field background      BackgroundProperties?
---@field shadow          ShadowProperties?


---@class FontDescriptor
---@field family string?
---@field style  string?
---@field size   number?

---@class BackgroundProperties
---@field drawing       SBoolean?      If the background should be rendered
---@field color         SARGBHex?      Fill color of the background
---@field border_color  SARGBHex?      Color of the backgrounds border
---@field border_width  SPositiveInt?  Width of the background border
---@field height        SPositiveInt?  Overrides the height of the background
---@field corner_radius SPositiveInt?  Corner radius of the background
---@field padding_left  SInt?          Padding to the left of the background
---@field padding_right SInt?          Padding to the right of the background
---@field y_offset      SInt?          Vertical offset applied to the background
---@field clip          number?        By how much the background clips the bar (i.e. transparent holes in the bar)
---@field image         ImageProperties?
---@field shadow        ShadowProperties?


---@class ImageProperties
---@field drawing       SBoolean?       If the image should draw
---@field scale         number?         The scale factor that should be applied to the image
---@field border_color  SARGBHex?       Color of the image border
---@field border_width  SPositiveInt?   Width of the image border
---@field corner_radius SPositiveInt?   Corner radius of the image
---@field padding_left  SInt?           Padding to the left of the image
---@field padding_right SInt?           Padding to the right of the image
---@field y_offset      SInt?           Vertical offset applied to the image
---@field string        string?         The image to display in the bar of form <path>, app.<bundle-id>, app.<name>, or media.artwork
---@field shadow        ShadowProperties

---@class ShadowProperties
---@field drawing  SBoolean?      If the shadow should be drawn
---@field color    SARGBHex?      Color of the shadow
---@field angle    SPositiveInt?  Angle of the shadow
---@field distance SPositiveInt?  Distance of the shadow

---@alias ExecCallback fun(result: string | table, exit_code: number)
---@alias SubscribeFunction fun(env: table)
---@alias AnimationFunction fun(env: table)

---@class SbarItem
---@field set       fun(self: SbarItem, properties: ItemProperties)
---@field subscribe fun(self: SbarItem, events: string | string[], callback: SubscribeFunction)
---@field query     fun(): ItemProperties

---@class SbarGraph : SbarItem
---@field push fun(self: SbarGraph, floats: number[])

---@type Sketchybar
---@global sbar
sbar = nil

---@class Sketchybar
local Sbar = {}

Sbar.begin_config = function() end
Sbar.end_config = function() end
Sbar.event_loop = function() end

---@param enabled boolean
Sbar.hotload = function(enabled) end


---Executes a shell command without blocking the event handler. An optional `callback`
---can be supplied that can use the result. If the result of the shell command
---is a JSON structure, it is parsed into table first then handed to the callback.
---@param command string
---@param callback ExecCallback?
Sbar.exec = function(command, callback) end

---@param properties BarProperties
Sbar.bar = function(properties) end

---@param event     string
---@param env_table table?
Sbar.trigger = function(event, env_table) end

---@param func AnimationFunction
Sbar.animate = function(curve, duration, func) end

---@param type "item" | "space" | "alias"
---@param name string?
---@param properties ItemProperties
---@return SbarItem
Sbar.add = function(type, name, properties) end

---@param type "bracket"
---@param name string?
---@param member_table table
---@param properties ItemProperties
---@return SbarItem
Sbar.add = function(type, name, member_table, properties) end

---@param type "slider"
---@param name string?
---@param width number
---@param properties ItemProperties
---@return SbarItem
Sbar.add = function(type, name, width, properties) end

---@param type "graph"
---@param name string?
---@param width number
---@param properties ItemProperties
---@return SbarGraph
Sbar.add = function(type, name, width, properties) end

---@param type "event"
---@param name string
---@param ns_notification string?
---@return SbarItem
Sbar.add = function(type, name, ns_notification) end
