--========== Copyleft © 2010, Team Sandbox, Some rights reserved. ===========--
--
-- Purpose: 
--
--===========================================================================--

require( "concommand" )

local hContentDialog = INVALID_PANEL

local function PositionDialog(dlg)
	if ( dlg == INVALID_PANEL ) then
		return;
	end

	local x, y, ww, wt, wide, tall;
	x, y, ww, wt = surface.GetWorkspaceBounds();
	wide, tall = dlg:GetSize();

	-- Center it, keeping requested size
	dlg:SetPos(x + ((ww - wide) / 2), y + ((wt - tall) / 2));
end

local function ContentDialog()
	local hFrame = vgui.Frame(VGui_GetGameUIPanel(), "ContentDialog")
	hFrame:SetBounds(0, 0, 512, 406);
	hFrame:SetSizeable( false );

	hFrame:SetTitle("#GameUI_Content", true);
	return hFrame
end

local function OnOpenContentDialog()
	if ( hContentDialog == INVALID_PANEL ) then
		hContentDialog = ContentDialog();
		PositionDialog( hContentDialog );
	end
	hContentDialog:Activate();
end

concommand.Create( "OpenContentDialog", OnOpenContentDialog, "Open content dialog.", 2^3 )
