#ifndef PLAYER_H
#define PLAYER_H

#include <godot_cpp/classes/character_body2d.hpp>
#include <godot_cpp/classes/sprite2d.hpp>

namespace godot {

/**
 * @brief Player class
 * 
 * @property Add properties here
 */
class Player : public CharacterBody2D {
    GDCLASS(Player, CharacterBody2D)

private:
    const double SPEED = 200.0;
    const double ACCEL = 2.0;

    Vector2 input = Vector2(0, 0);

protected:
    static void _bind_methods();

public:
    Player();
    ~Player();

    // Godot Callbacks
    void _ready() override;

    void _process(double delta) override;
    void _physics_process(double delta) override;

    void _enter_tree() override;
    void _exit_tree() override;

    // Methods
    Vector2 get_input() const;

    // Properties getters and setters

};

}

#endif