/*-------------------------------------------------------------------------------------------------------------------------
	Teleport a player
-------------------------------------------------------------------------------------------------------------------------*/

local PLUGIN = { }
PLUGIN.Title = "Teleport"
PLUGIN.Description = "Teleport a player."
PLUGIN.Author = "Overv"
PLUGIN.ChatCommand = "tp"
PLUGIN.Usage = "[players]"

function PLUGIN:Call( ply, args )
	if ( ply:EV_IsAdmin( ) and ply:IsValid( ) ) then	
		local pls = evolve:findPlayer( args, ply )
				
		if ( #pls > 0 ) then
			local tr = ply:GetEyeTrace( )
			local pos = tr.HitPos
			for i, pl in pairs( pls ) do
				pl:SetPos( pos + i * tr.HitNormal * 128 )
			end
			
			evolve:notify( evolve.colors.blue, ply:Nick( ), evolve.colors.white, " has teleported ", evolve.colors.red, evolve:createPlayerList( pls ), evolve.colors.white, "." )
		else
			evolve:notify( ply, evolve.colors.red, "No matching players found." )
		end
	else
		evolve:notify( ply, evolve.colors.red, evolve.constants.notallowed )
	end
end

function PLUGIN:Menu( arg, players )
	if ( arg ) then
		RunConsoleCommand( "ev", "tp", unpack( players ) )
	else
		return "Teleport", evolve.category.teleportation
	end
end

evolve:registerPlugin( PLUGIN )