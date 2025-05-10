#include "player.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/classes/input.hpp>

#include "../actions.h"

using namespace godot;

void Player::_bind_methods() {
    // Bind methods to Godot here
    // ClassDB::bind_method("set_property_name", &Player::set_property_name);
    // ClassDB::bind_method(D_METHOD("set_property_name", "p_property_name"), &Player::set_property_name);
    // ADD_PROPERTY(PropertyInfo(Variant::FLOAT, "property_name"), "set_property_name", "get_property_name");
}

// Constructor
Player::Player() {
    // Initialization code here
}

// Destructor
Player::~Player() {
    // Cleanup code here
}

// ----------------------------------------------------
// Godot Callbacks
// ----------------------------------------------------

void Player::_ready() {
    
}

void Player::_process(double delta) {
    Vector2 input = this->get_input();

    set_velocity(get_velocity().lerp(input * SPEED, ACCEL * delta));

    move_and_slide();
}

void Player::_physics_process(double delta) {
    
}

void Player::_enter_tree() {
    
}

void Player::_exit_tree() {
    
}

// ----------------------------------------------------
// Methods
// ----------------------------------------------------

Vector2 Player::get_input() const {
    Input &_input = *Input::get_singleton();

    Vector2 input;
    input.x = _input.get_action_strength(Actions::MOVE_RIGHT) - _input.get_action_strength(Actions::MOVE_LEFT);
    input.y = _input.get_action_strength(Actions::MOVE_DOWN) - _input.get_action_strength(Actions::MOVE_UP);

    return input.normalized();
}

// ----------------------------------------------------
// Properties getters and setters
// ----------------------------------------------------
