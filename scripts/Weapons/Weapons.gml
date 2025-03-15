enum WeaponID {
	sword
}
	
function Weapon(WeaponID, weaponDamage, weaponRange, weaponName, weaponSprite) constructor{
	ID = WeaponID
	Damage = weaponDamage
	Range = weaponRange
	Name = weaponName
	Slot = PlayerEquipment.Weapon; //Ensures weapons only go in weapon slots
	Sprite = weaponSprite; // Store weapon sprite
}

