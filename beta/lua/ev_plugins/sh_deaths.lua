/*-------------------------------------------------------------------------------------------------------------------------
	Set the deaths of a player
-------------------------------------------------------------------------------------------------------------------------*/

local PLUGIN = { }
PLUGIN.Title = "Deaths"
PLUGIN.Description = "Set the deaths of a player."
PLUGIN.Author = "Overv"
PLUGIN.ChatCommand = "deaths"
PLUGIN.Usage = "<players> [deaths]"

function PLUGIN:Call( ply, args )
	if ( ply:EV_IsAdmin() ) then
		local pls = evolve:FindPlayer( args, ply, true )
		if ( #pls > 0 and !pls[1]:IsValid() ) then pls = { } end
		local deaths = 0
		if ( tonumber( args[ #args ] ) ) then deaths = tonumber( args[ #args ] ) end
		
		for _, pl in ipairs( pls ) do
			pl:SetDeaths( deaths )
		end
		
		if ( #pls > 0 ) then
			evolve:Notify( evolve.colors.blue, ply:Nick(), evolve.colors.white, " has set the deaths of ", evolve.colors.red, evolve:CreatePlayerList( pls ), evolve.colors.white, " to " .. deaths .. "." )
		else
			evolve:Notify( ply, evolve.colors.red, "No matching players found." )
		end
	else
		evolve:Notify( ply, evolve.colors.red, evolve.constants.notallowed )
	end
end

function PLUGIN:Menu( arg, players )
	if ( arg ) then
		table.insert( players, arg )
		RunConsoleCommand( "ev", "deaths", unpack( players ) )
	else
		args = { }
		for i = 0, 20 do
			args[i+1] = { i }
		end
		return "Deaths", evolve.category.actions, args
	end
end

evolve:RegisterPlugin( PLUGIN )