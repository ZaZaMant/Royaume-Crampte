class_name Inventory

var _content: Array[Item] = []

func add_item(item: Item):
	_content.append(item)

func remove_item(item: Item):
	_content.erase(item)

func get_item() -> Array[Item]:
	return _content;
