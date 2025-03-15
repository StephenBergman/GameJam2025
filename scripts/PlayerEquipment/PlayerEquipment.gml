enum PlayerEquipment {
	Armor,
	Weapon,
	LeftRing,
	RightRing,
	Amulet,
	noone
}

function Player() constructor{
	equipment = {
	Weapon: noone, //No items equipped initially
	Armor: noone,
	LeftRing: noone,
	RightRing: noone,
	Amulet: noone
	};
	
	equipmentInventory = []; //Player's equipment
	
	equipItem = function (item) {
		switch (item.Slot) {
			case PlayerEquipment.Weapon:
			self.equipment.Weapon = item;
			break;
			
			case PlayerEquipment.Armor:
			self.equipment.Armor = item;
			break;
			
			case PlayerEquipment.LeftRing:
			self.equipment.LeftRing = item;
			break;
			
			case PlayerEquipment.RightRing:
			self.equipment.RightRing = item;
			break;
			
			case PlayerEquipment.Amulet:
			self.equipment.Amulet = item;
			break;
	}
};

addToInventory = function (item) {
	array_push(self.equipmentInventory, item);
	};
}

global.player = new Player(); 
