#ifndef PLAYER_H
#define PLAYER_H

#include <godot_cpp/classes/animated_sprite2d.hpp>

namespace godot {

/**
 * @brief  class
 *
 * @property Add properties here
 */
class Player : public AnimatedSprite2D {
	GDCLASS(Player, AnimatedSprite2D)

private:
	int hp;
	double speed;
	int satiete;
	int hydratation;
	godot::Array inventaire;

protected:
	static void
	_bind_methods();

public:
	Player(); // Constructor
	~Player(); // Destructor

	// Godot Callbacks
	void _ready() override;

	void _process(double delta) override;
	//  delta représente le temps écoulé entre les
	// deux dernières frame en secondes.

	void _physics_process(double delta) override;
	// physics process lui est appelé de manière régulière
	// sans prendre en compte les frames

	double set_velocity(double p_velocity);

	// Methods

	// Properties getters and setters
};

} //namespace godot

#endif