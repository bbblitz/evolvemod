/*-------------------------------------------------------------------------------------------------------------------------
	Bring a player to you
-------------------------------------------------------------------------------------------------------------------------*/

local PLUGIN = { }
PLUGIN.Title = "Bring"
PLUGIN.Description = "Bring a player."
PLUGIN.Author = "Overv"
PLUGIN.ChatCommand = "bring"
PLUGIN.Usage = "[players]"

function PLUGIN:Call( ply, args )
	if ( ply:EV_IsAdmin() and ply:IsValid() ) then	
		local pl = evolve:FindPlayer( args, ply )
		
		for i, pl2 in pairs( pl ) do
			pl2:SetPos( ply:GetPos() + Vector( 0, 0, i * 128 ) )
		end
		
		if ( #pl > 0 ) then
			evolve:Notify( evolve.colors.blue, ply:Nick(), evolve.colors.white, " has brought ", evolve.colors.red, evolve:CreatePlayerList( pl ), evolve.colors.white, " to them." )
		else
			evolve:Notify( ply, evolve.colors.red, "No matching players found." )
		end
	else
		evolve:Notify( ply, evolve.colors.red, evolve.constants.notallowed )
	end
end

function PLUGIN:Menu( arg, players )
	if ( arg ) then
		RunConsoleCommand( "ev", "bring", unpack( players ) )
	else
		return "Bring", evolve.category.teleportation
	end
end

evolve:RegisterPlugin( PLUGIN )