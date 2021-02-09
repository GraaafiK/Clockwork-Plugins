local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	for i=1,#StackedVarsList do
		playerVars:Number(tostring(StackedVarsList[i]), true);
	end;
end;

function PLUGIN:AddStackedVar(name, default, )


end;


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
