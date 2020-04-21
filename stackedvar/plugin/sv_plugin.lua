
Clockwork.config:Add("stackedvars_power", 2);
Clockwork.config:Add("stackedvars_debug", false);


function PLUGIN:PlayerRestoreCharacterData(player, data)
	if ( !data["stackedvars"] or !data["stackedvarspower"] or data["stackedvarspower"] != Clockwork.config:Get("stackedvars_power"):Get()) then
		Clockwork.plugin:Call("ResetStackedVars", player, data)
	end;
	if ( !data["stackedvarspower"] ) then
		data["stackedvarspower"] = Clockwork.config:Get("stackedvars_power"):Get();
	end;
end;

function PLUGIN:PlayerSaveCharacterData(player, data)
	if ( !data["stackedvars"] or !data["stackedvarspower"] or data["stackedvarspower"] == Clockwork.config:Get("stackedvars_power"):Get()) then
		data["stackedvars"] = data["stackedvars"];
		data["stackedvarspower"] = data["stackedvarspower"];
	else
		Clockwork.plugin:Call("ResetStackedVars", player, data)
	end;
end;

function PLUGIN:PlayerSetSharedVars(player, curTime)
	for i=1,#StackedVarsList do
		player:SetSharedVar(tostring(StackedVarsList[i]), Clockwork.plugin:Call("GetStackedVar", player, StackedVarsList[i] or i));
	end;
end;
 
function Clockwork:ResetStackedVars(player, data)
	data["stackedvars"] = 0;
	data["stackedvarspower"] = Clockwork.config:Get("stackedvars_power"):Get();
	if Clockwork.config:Get("stackedvars_power"):Get() <= 2 then
		for i=1,#StackedVarsList do
			if StackedVarsDefaultValueListPower2[i] == true or StackedVarsDefaultValueListPower2[i] == 1 then
				data["stackedvars"] = data["stackedvars"] + Clockwork.config:Get("stackedvars_power"):Get()^(i-1);
			end;
		end;
	else
		for i=1,#StackedVarsList do
			data["stackedvars"] = data["stackedvars"] + StackedVarsDefaultValueListPowerCst[i]*Clockwork.config:Get("stackedvars_power"):Get()^(i-1);
		end;
	end;
end;

function Clockwork:GetStackedVar(player, var)
	local varget = 0;
	if type(var) == "number" then
		varget = var;
	else
		var = tostring(var);
	end;
	if varget == 0 then
		for i=1,#StackedVarsList do
			if var == StackedVarsList[i] then
				varget = i;
			end;
		end;
	end;
	if varget == 0 then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, "Can't find your value.");
		end;
		return false;
	end;
	local currentstacked = player:GetCharacterData("stackedvars");
	local coef = Clockwork.config:Get("stackedvars_power"):Get()^varget
	local var = math.floor(currentstacked/coef)
	local truevar = currentstacked-var*coef;
	-- if Clockwork.config:Get("stackedvars_debug"):Get() then
		-- Clockwork.player:Notify(player, "Current ALLstackedvar "..currentstacked);
	-- end;
	if math.floor(truevar/Clockwork.config:Get("stackedvars_power"):Get()^(varget-1)) >= 1 then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, StackedVarsList[varget].." : "..math.floor(truevar/Clockwork.config:Get("stackedvars_power"):Get()^(varget-1)));
		end;
		return math.floor(truevar/Clockwork.config:Get("stackedvars_power"):Get()^(varget-1));
	else
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, StackedVarsList[varget].." : 0");
		end;
		return 0;
	end;
	if Clockwork.config:Get("stackedvars_debug"):Get() then
		Clockwork.player:Notify(player, "Can't return value.");
	end;
	return false;
end;

function Clockwork:SetStackedVar(player, var, x)
	local varadd = 0;
	if type(var) == "number" then
		varadd = var;
	else
		var = tostring(var);
	end;
	local x = tonumber(x);
	if x > (Clockwork.config:Get("stackedvars_power"):Get()-1) then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, "Your value must be between 0 and "..(Clockwork.config:Get("stackedvars_power"):Get()-1));
		end;
		return false;
	end;
	local currentstacked = player:GetCharacterData("stackedvars");
	if varadd == 0 then
		for i=1,#StackedVarsList do
			if var == StackedVarsList[i] then
				varadd = i;
			end;
		end;
	end;
	if varadd == 0 then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, "Can't find your value to change.");
		end;
		return false;
	end;
	local currentvalue = Clockwork.plugin:Call("GetStackedVar", player, varadd);
	if currentvalue and currentvalue == x then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, StackedVarsList[varadd].." is already set to "..x);
		end;
		return false;
	elseif x >= Clockwork.config:Get("stackedvars_power"):Get() then
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, "Value too high, you may override next one instead.");
		end;
		return false;
	else
		local diff = x - currentvalue;
		player:SetCharacterData("stackedvars", currentstacked+(diff*Clockwork.config:Get("stackedvars_power"):Get()^(varadd-1)));
		if Clockwork.config:Get("stackedvars_debug"):Get() then
			Clockwork.player:Notify(player, "New value : "..Clockwork.plugin:Call("GetStackedVar", player, varadd));
		end;
	end;
end;

function Clockwork:GetStackedVarNumber()
	return #StackedVarsList;
end;

function Clockwork:GetStackedVarName(id)
	if type(id) == "number" then
		realid = id
	else
		for i=1,#StackedVarsList do
			if id == StackedVarsList[i] then
				realid = i;
			end;
		end;
	end;
	return StackedVarsList[realid];
end;

