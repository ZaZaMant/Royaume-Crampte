#ifndef _H
#define _H

#include <godot_cpp/classes/.hpp>

namespace godot {

/**
 * @brief  class
 *
 * @property Add properties here
 */
class : public {
	GDCLASS(, )

private:
protected:
	static void _bind_methods();

public:
	(); // Constructor
	~(); // Destructor

	// Godot Callbacks
	void _ready() override;

	void _process(double delta) override;
	void _physics_process(double delta) override;

	void _enter_tree() override;
	void _exit_tree() override;

	void _input(const Ref<InputEvent> &event) override;

	// Methods

	// Properties getters and setters
};

} //namespace godot

#endif