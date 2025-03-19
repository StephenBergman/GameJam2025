enum EnemyState{
Idle,
Alert,
Attack,
Wander,
Dead
}

global.sprites_array = array_create(5);

sprites_array [EnemyState.Idle] = sOrcIdle;
sprites_array [EnemyState.Alert] = sOrcRun;
sprites_array [EnemyState.Wander] = sOrcWalk;
sprites_array [EnemyState.Attack] = sOrcAttack;
sprites_array [EnemyState.Dead] = sOrcDead;

// EnemyAI Constructor
function EnemyAI(_enemy) constructor {
    
		flash = _enemy.flash;
        enemy = _enemy;    // Reference to the enemy instance
        state =_enemy.state; // Initial state
        counter = 0;         // Action timer
        move_rate = 2   // Movement speed
        move_dir = irandom_range(0, 90);	   // Movement direction
		moveX = lengthdir_x(move_rate, move_dir); //Movement direction horiz
		moveY = lengthdir_y(move_rate, move_dir); //Movement direction vert
	

        // Function to update AI each frame
		   step = function () {
			//   show_debug_message(
			//    "AI Debug - State: " + string(self.state) +
			//    " | hspeed: " + string(self.enemy.hspeed) +
			//    " | vspeed: " + string(self.enemy.vspeed)
			//);
            //show_debug_message("EnemyAI Step Running - State: " + string(self.state));
			
			// Preserve vspeed when changing states
			var prev_vspeed = self.enemy.vspeed;
			
			//Assign sprite based on state
			self.enemy.sprite_index = global.sprites_array[self.state];
			
			// Ensure tile collision is checked AFTER sprite change
			//if (tile_meeting(self.enemy.x, self.enemy.y + 1)) {
			//    self.enemy.vspeed = 0;
			//} else {
			//    self.enemy.vspeed += 0.3; // Apply gravity
			//}

            switch (self.state) {
                case EnemyState.Idle:
                    self.counter += 1;

                    if (self.counter >= room_speed * 3) {
                        self.state = choose(EnemyState.Idle, EnemyState.Wander);
                        self.counter = 0; // Reset counter
                    }

                    if (collision_circle(self.enemy.x, self.enemy.y, 32, oPlayer, false, false)) {
                        self.state = EnemyState.Alert;
                    }
                    break;
					
                 case EnemyState.Wander:
                    // Update direction only when switching to Wander
                    if (self.counter == 0) {
                        self.move_dir = irandom_range(0, 90);
						 if (oPlayer.x < self.enemy.x) {
						self.enemy.image_xscale = -1; // Face left
						 } else {
						self.enemy.image_xscale = 1;  // Face right
						}
                    }
                    
                    // Move in the selected direction
                    self.enemy.hspeed = lengthdir_x(self.move_rate, self.move_dir);
                    //self.enemy.vspeed = lengthdir_y(self.move_rate, self.move_dir);

                    //show_debug_message("Wander State - Moving Direction: " + string(self.move_dir));

                    self.counter += 1;

                    if (self.counter >= room_speed * 2) {
                        self.state = EnemyState.Idle;
                        self.counter = 0; // Reset counter
                        self.enemy.hspeed = 0;
                        self.enemy.vspeed = 0;
                    }
                    break;
					
                case EnemyState.Alert:
                    var angle = point_direction(self.enemy.x, self.enemy.y, oPlayer.x, oPlayer.y);
                    self.enemy.hspeed = cos(degtorad(angle)) * self.move_rate;
                    //self.enemy.vspeed = sin(degtorad(angle)) * self.move_rate;
						if (oPlayer.x < self.enemy.x) {
						self.enemy.image_xscale = -1; // Face left
						} else {
						self.enemy.image_xscale = 1;  // Face right
						 }
						 
                    if (distance_to_object(oPlayer) < 32) {
                        self.state = EnemyState.Attack;
                    }
                    break;

                case EnemyState.Attack:
                    break;

                case EnemyState.Dead:
                    instance_destroy(_enemy);
                    break;
            }

           
        }
	};




