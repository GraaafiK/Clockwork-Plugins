local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	for i=1,#StackedVarsList do
		playerVars:Number(tostring(StackedVarsList[i]), true);
	end;
end;

function PLUGIN:AddStackedVar(name, default)
	if type(name) == "string" then
		if table.HasValue(StackedVarsList,name) then
			print("Error trying to add a already used value name");
		else
			StackedVarsList[#StackedVarsList+1] = name;
		end;
	else
		print("Error trying to add a non string value name");
	end
	if Clockwork.config:Get("stackedvars_power") > 2 then
		if type(default) == "number"  then
			StackedVarsDefaultValueListPowerCst[#StackedVarsDefaultValueListPowerCst+1] = default;
		else
			print("Error trying to add a non number default value");
		end;
	else
		if type(default) == "bool" or type(default) == "number" then
			StackedVarsDefaultValueListPower2[#StackedVarsDefaultValueListPower2+1] = default;
		else
			print("Error trying to add a non bool/number default value");
		end;
	end;
end;

StackedVarsList = {}
StackedVarsDefaultValueListPower2 = {}
StackedVarsDefaultValueListPowerCst = {}

PLUGIN:AddStackedVar("Valeur1", true)
PLUGIN:AddStackedVar("Valeur2", false)
PLUGIN:AddStackedVar("Valeur3", false)

/////////////////////////////////
-- Clockwork.config:Get("stackedvars_power"):Get()^#StackedVarsList MUST ALWAYS BE INCLUDED BETWEEN 0 AND 2^32
/////////////////////////////////

--Old method.
--[[
StackedVarsList = { --Simple value name
	"Valeur1",
	"Valeur2",
	"Valeur3",
	"Valeur4",
	"Valeur5"
}
StackedVarsDefaultValueListPower2 = { --Both true and 1 works. false and 0.
	true,
	false,
	false,
	false,
	true
}

StackedVarsDefaultValueListPowerCst = { --Only used if Clockwork.config:Get("stackedvars_power"):Get() > 2, EXP FEATURE
	1,
	2,
	0,
	0,
	2
}
]]