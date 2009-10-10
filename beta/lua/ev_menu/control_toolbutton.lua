local ToolButtons = { }

local PANEL = { }

AccessorFunc( PANEL, "m_bAlt", 			"Alt" )
AccessorFunc( PANEL, "m_bSelected", 	"Selected" )

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Init()

	self:SetContentAlignment( 4 ) 
	self:SetTextInset( 5 )
	self:SetTall( 15 )
	table.insert( ToolButtons, self )
	
end

function PANEL:RemoveEx()
	for k, v in pairs( ToolButtons ) do
		if ( v == self ) then
			table.remove( ToolButtons, k )
			break
		end
	end
	self:Remove()
end

function PANEL:Paint()

	if ( !self.m_bSelected ) then
		if ( !self.m_bAlt ) then return end
		surface.SetDrawColor( 255, 255, 255, 10 )
	else
		surface.SetDrawColor( 50, 150, 255, 250 )
	end
	
	self:DrawFilledRect()
	
end

/*---------------------------------------------------------
   Name: OnMousePressed
---------------------------------------------------------*/
function PANEL:OnMousePressed( mcode )

	if ( mcode == MOUSE_LEFT ) then
		self:OnSelect()
	end
	
end

/*---------------------------------------------------------
   Name: OnMousePressed
---------------------------------------------------------*/
function PANEL:OnCursorMoved( x, y )

	for _, b in pairs( ToolButtons ) do b.m_bSelected = false end
	self.m_bSelected = true
	
end


/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:OnSelect()

	// Override
	
end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:PerformLayout()

	if ( self.Checkbox ) then
	
		self.Checkbox:AlignRight( 4 )
		self.Checkbox:CenterVertical()
	
	end
	
end

function PANEL:AddCheckBox( strConVar )

	if ( !self.Checkbox ) then 
		self.Checkbox = vgui.Create( "DCheckBox", self )
	end
	
	self.Checkbox:SetConVar( strConVar )
	self:InvalidateLayout()

end

vgui.Register( "ToolMenuButton", PANEL, "DButton" )