equipItem = function (item) {
    if (item != noone) {
        switch (item.slot) {
            case PlayerEquipment.Weapon:
                show_debug_message("Equipping Weapon: " + item.Name);
                self.equipment.Weapon = item;
                break;

            case PlayerEquipment.Armor:
                show_debug_message("Equipping Armor: " + item.Name);
                self.equipment.Armor = item;
                break;
        }
    } else {
        show_debug_message("No valid item to equip!");
    }
};