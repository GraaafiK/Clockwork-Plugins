
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("chargetallstackedvars");
COMMAND.tip = "Get all stacked vars from a player";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID( arguments[1] )
	if (target) then
		for i=1,Clockwork.plugin:Call("GetStackedVarNumber") do
			Clockwork.player:Notify(player, Clockwork.plugin:Call("GetStackedVarName", i).." : "..Clockwork.plugin:Call("GetStackedVar", player, i));
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." isnt a valid player !");
	end;

end;

COMMAND:Register();