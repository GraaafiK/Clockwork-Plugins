
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("charsetstackedvar");
COMMAND.tip = "Set the selected stacked vars from a player";
COMMAND.text = "<string Name> <number id value or string name value> <New value>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 3;
COMMAND.optionalArguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	if type(tonumber(arguments[3])) != "number" then
		Clockwork.player:Notify(player, "Your value must be a number.");
		return false;
	end;
	if (target) then
		if type(tonumber(arguments[2])) == "number" then
			Clockwork.plugin:Call("SetStackedVar", player, tonumber(arguments[2]), tonumber(arguments[3]))
			Clockwork.player:Notify(player, "The new value of "..Clockwork.plugin:Call("GetStackedVarName", tonumber(arguments[2])).." is now "..Clockwork.plugin:Call("GetStackedVar", player, tonumber(arguments[2])));
		elseif type(arguments[2]) == "string" then
			Clockwork.plugin:Call("GetStackedVar", player, arguments[2], tonumber(arguments[3]))
			Clockwork.player:Notify(player, "The new value of "..Clockwork.plugin:Call("GetStackedVarName", arguments[2]).." is now "..Clockwork.plugin:Call("GetStackedVar", player, arguments[2]));
		else
			Clockwork.player:Notify(player, "Error");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." isnt a valid player !");
	end;
end;

COMMAND:Register();