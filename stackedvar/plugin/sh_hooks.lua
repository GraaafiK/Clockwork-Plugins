local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	for i=1,#StackedVarsList do
		playerVars:Number(tostring(StackedVarsList[i]), true);
	end;
end;

--There is no limit value.

/////////////////////////////////
-- Clockwork.config:Get("stackedvars_power"):Get()^#StackedVarsList MUST ALWAYS BE INCLUDED BETWEEN 0 AND 2^64
/////////////////////////////////

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

-- if Clockwork.config:Get("stackedvars_power"):Get() <= 2 then
	-- if #StackedVarsList != #StackedVarsDefaultValueListPower2 then
		-- print("ULTRA ERROR t1");
	-- end;
-- else
	-- if #StackedVarsList != #StackedVarsDefaultValueListPower2 or #StackedVarsDefaultValueListPower2 != #StackedVarsDefaultValueListPowerCst or #StackedVarsList != #StackedVarsDefaultValueListPowerCst then
		-- print("ULTRA ERROR t2");
	-- end;
-- end;