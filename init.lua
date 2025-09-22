dofile("expansions-2/proc_order.lua")
dofile("expansions-2/init_Spinel.lua")

dofile("expansions-2/OriCS-procs/_custom_type.lua")
dofile("expansions-2/OriCS-procs/custom_card_type_constants.lua")
dofile("expansions-2/OriCS-procs/ygocore_utility.lua")
dofile("expansions-2/OriCS-procs/proc_square.lua")
dofile("expansions-2/OriCS-procs/proc_module.lua")
dofile("expansions-2/OriCS-procs/proc_delight.lua")

--[[

UnlimitChain={}

local dschlim=Duel.SetChainLimit
function Duel.SetChainLimit(f)
	dschlim(function(e,ep,tp)
		for _,te in pairs(UnlimitChain) do
			if e==te then
				return true
			end
		end
		return f(e,ep,tp)
	end)
end


local dgcc=Duel.GetCurrentChain
Auxiliary.CheckDisSumAble=false
function Duel.GetCurrentChain()
	if Auxiliary.CheckDisSumAble and dgcc()>0 then
		return dgcc()-1
	end
	return dgcc()
end

local cregeff=Card.RegisterEffect
Auxiliary.MetatableEffectCount=true
function Card.RegisterEffect(c,e,forced,...)
	local code=c:GetOriginalCode()
	local mt=_G["c"..code]
	if c:IsStatus(STATUS_INITIALIZING) and Auxiliary.MetatableEffectCount then
		if not mt.eff_ct then
			mt.eff_ct={}
		end
		if not mt.eff_ct[c] then
			mt.eff_ct[c]={}
		end
		local ct=0
		while true do
			if mt.eff_ct[c][ct]==e then
				break
			end
			if not mt.eff_ct[c][ct] then
				mt.eff_ct[c][ct]=e
				break
			end
			ct=ct+1
		end
	end
	cregeff(c,e,forced,...)
end

--]]
