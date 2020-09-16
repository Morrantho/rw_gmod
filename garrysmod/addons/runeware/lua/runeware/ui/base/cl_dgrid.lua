if !ui.enabled then return; end
local PANEL = {}

function PANEL:PerformLayout()
	self:SetContentAlignment(5);

	local i = 0

	self.m_iCols = math.floor( self.m_iCols )

	for k, panel in pairs( self.Items ) do

		local x = ( i % self.m_iCols ) * self.m_iColWide
		local y = math.floor( i / self.m_iCols ) * self.m_iRowHeight
		panel:SetContentAlignment(5);
		panel:SetPos( math.ceil(x), math.ceil(y) )

		i = i + 1
	end

	self:SetWide( self.m_iColWide * self.m_iCols )
	self:SetTall( math.ceil( i / self.m_iCols ) * self.m_iRowHeight )

end

ui.add("cl_dgrid", PANEL, "DGrid")