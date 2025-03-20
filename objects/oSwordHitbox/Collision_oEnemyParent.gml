//show_debug_message("Collision Check: Sword vs " + string(other));

// Make sure "other" is actually an enemy instance
if (other.object_index == oEnemyParent || object_is_ancestor(other.object_index, oEnemyParent)) {
    other.hp--; // Reduce enemy health
    //show_debug_message("Hit detected! Setting flash to 3 for " + string(other));
    
    //  Set flash for the specific enemy instance that was hit
    other.flash = 3;

    // Destroy the hitbox after impact
    instance_destroy();
}
