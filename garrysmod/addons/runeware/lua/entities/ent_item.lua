AddCSLuaFile();

ENT.Base         = "base_gmodentity";
ENT.Type         = "anim";
ENT.Category     = "rw";
ENT.Spawnable    = true;
ENT.AdminOnly    = true;
ENT.Author       = "pyg";
ENT.PrintName    = "Item";
ENT.RenderGroup  = 8;
ENT.Instructions = "";

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/Gibs/HGIBS.mdl");
	end
end

function ENT:Use(pl,_,_,_)
	if !SERVER then return; end
	if !self.itemname then return; end
	pl:additem(self.itemname,self.quantity,self.durability);
	self:Remove();
end

function ENT:Draw()
	if !CLIENT then return; end
	self:DrawModel();
	item.draw(self);
end