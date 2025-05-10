#include "player.h"
#include <godot_cpp/core/class_db.hpp>

#include <godot_cpp/classes/input.hpp>

using namespace godot;

void Player::_bind_methods() {
	// Bind methods to Godot here
	// ClassDB::bind_method("set_property_name", &::set_property_name);
	// ClassDB::bind_method(D_METHOD("set_property_name", "p_property_name"), &::set_property_name);
	// ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "property_name"), "set_property_name", "get_property_name");
}

// Constructor
Player::Player() {
	// Initialization code here
	speed = 5;
}

// Destructor
Player::~Player() {
	// Cleanup code here
}

// ----------------------------------------------------
// Godot Callbacks
// ----------------------------------------------------

void ::_ready() {
}

void ::_process(double delta) {
}

void ::_physics_process(double delta) {
	Vector2 velocity = Vector2();

	Ref<Input> input = Input::get_singleton();

	if (input->is_action_pressed("ui_right")) {
		velocity.x += 1;
	}
	if (input->is_action_pressed("ui_left")) {
		velocity.x -= 1;
	}
	if (input->is_action_pressed("ui_down")) {
		velocity.y += 1;
	}
	if (input->is_action_pressed("ui_up")) {
		velocity.y -= 1;
	}

	velocity = velocity.normalized() * speed;

	set_velocity(velocity);
	move_and_slide();
}

void ::_enter_tree() {
}

void ::_exit_tree() {
}

void ::_input(const Ref<InputEvent> &event) {
}

// ----------------------------------------------------
// Methods
// ----------------------------------------------------

// ----------------------------------------------------
// Properties getters and setters
// ----------------------------------------------------
