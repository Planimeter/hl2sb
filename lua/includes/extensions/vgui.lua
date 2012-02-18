--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: Extends the vgui library.
--
--===========================================================================--

if _CLIENT then
require( "vgui" );


local EditablePanel = vgui.EditablePanel

-- these includes are all for the contruction factory vgui.CreateControlByName()
local Button = vgui.Button
local Label = vgui.Label
local CheckButton = vgui.CheckButton
local ComboBox = vgui.ComboBox
local Menu = vgui.Menu
local MenuItem = vgui.MenuItem
local MessageBox = vgui.MessageBox
local ProgressBar = vgui.ProgressBar
local RadioButton = vgui.RadioButton
local ScrollBar = vgui.ScrollBar
local ToggleButton = vgui.ToggleButton
local ImagePanel = vgui.ImagePanel
local AnimatingImagePanel = vgui.AnimatingImagePanel
local Divider = vgui.Divider
local URLLabel = vgui.URLLabel
local RichText = vgui.RichText

-------------------------------------------------------------------------------
-- Purpose: Factory for control creation
-------------------------------------------------------------------------------
function vgui.CreateControlByName(controlName)
	if (controlName == "Label") then
		return Label(nil, nil, "Label");
	elseif (controlName == "Button") then
		return Button(nil, nil, "Button");
	elseif (controlName == "CheckButton") then
		return CheckButton(nil, nil, "CheckButton");
	elseif (controlName == "ComboBox") then
		return ComboBox(nil, nil, 5, true);
	elseif (controlName == "Menu") then
		return Menu(nil, "Menu");
	elseif (controlName == "MenuItem") then
		return MenuItem(nil, nil, "MenuItem");
	elseif (controlName == "MessageBox") then
		return MessageBox("MessageBox", "MessageBoxText");
	elseif (controlName == "ProgressBar") then
		return ProgressBar(nil, nil);
	elseif (controlName == "RadioButton") then
		return RadioButton(nil, nil, "RadioButton");
	elseif (controlName == "ScrollBar") then
		return ScrollBar(nil, nil, false);
	elseif (controlName == "TextEntry") then
		return TextEntry(nil, nil);
	elseif (controlName == "RichText") then
		return RichText(nil, nil);
	elseif (controlName == "ToggleButton") then
		return ToggleButton(nil, nil, "ToggleButton");
	elseif (controlName == "ImagePanel") then
		return ImagePanel(nil, "ResourceImagePanel");
	elseif (controlName == "AnimatingImagePanel") then
		return AnimatingImagePanel(nil, nil);
	elseif (controlName == "Panel") then
		return Panel(nil, nil);
	elseif (controlName == "Divider") then
		return Divider(nil, "Divider");
    elseif (controlName == "URLLabel") then
        return URLLabel(nil, nil, "URLLabel", nil);
	elseif (controlName == "EditablePanel") then
		return EditablePanel(nil, nil);
	end


	return INVALID_PANEL;
end
end

