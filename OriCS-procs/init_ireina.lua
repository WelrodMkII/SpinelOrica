local dgcc=Duel.GetCurrentChain
Auxiliary.CheckDisSumAble=false
function Duel.GetCurrentChain()
	if Auxiliary.CheckDisSumAble and dgcc()>0 then
		return dgcc()-1
	end
	return dgcc()
end