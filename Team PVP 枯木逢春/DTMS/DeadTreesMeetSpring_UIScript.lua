
-- ===========================================================================
-- 变量定义
local m_iCurrentPlayerID = Game.GetLocalPlayer()
local m_pCurrentPlayer = Players[m_iCurrentPlayerID]
local Debug_mode = 1;
-- ===========================================================================
function __DEBUG(...)
	if Debug_mode then
		print(...)
	end
end

-- ===========================================================================

-- ===========================================================================
-- 文件初始化
function Initialize()
	print('DTMS UIScript Loaded Succeed.');
end
Events.LoadGameViewStateDone.Add(Initialize);
