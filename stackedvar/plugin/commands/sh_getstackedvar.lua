
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("chargetstackedvar");
COMMAND.tip = "Get the selected stacked vars from a player";
COMMAND.text = "<string Name> <number id value or string name value>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 2;
COMMAND.optionalArguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	if (target) then
		if type(tonumber(arguments[2])) == "number" then
			Clockwork.player:Notify(player, "La valeur de "..Clockwork.plugin:Call("GetStackedVarName", tonumber(arguments[2])).." : "..Clockwork.plugin:Call("GetStackedVar", player, tonumber(arguments[2])));
		elseif type(arguments[2]) == "string" then
			Clockwork.player:Notify(player, "La valeur de "..Clockwork.plugin:Call("GetStackedVarName", arguments[2]).." : "..Clockwork.plugin:Call("GetStackedVar", player, arguments[2]));
		else
			Clockwork.player:Notify(player, "Error");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." isnt a valid player !");
	end;

end;

COMMAND:Register();