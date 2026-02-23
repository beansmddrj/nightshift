extends Node

const HEAT_BUST_THRESHOLD: int = 100
const DEFAULT_CAR_STATS := {
	"power": 5,
	"grip": 5,
	"reliability": 5,
	"boost": 5
}

var night: int = 1
var rep: int = 0
var heat: int = 0
var cash: int = 100
var car_stats: Dictionary = DEFAULT_CAR_STATS.duplicate(true)

func reset_for_new_night() -> void:
	night += 1
	heat = 0

func add_rep(amount: int) -> void:
	rep = max(rep + amount, 0)

func add_cash(amount: int) -> void:
	cash = max(cash + amount, 0)

func add_heat(amount: int) -> void:
	set_heat(heat + amount)

func set_heat(value: int) -> void:
	heat = max(value, 0)

func is_busted() -> bool:
	return heat >= HEAT_BUST_THRESHOLD

func to_dict() -> Dictionary:
	return {
		"night": night,
		"rep": rep,
		"heat": heat,
		"cash": cash,
		"car": car_stats.duplicate(true)
	}

func load_from_dict(data: Dictionary) -> void:
	night = int(data.get("night", 1))
	rep = int(data.get("rep", 0))
	heat = int(data.get("heat", 0))
	cash = int(data.get("cash", 100))

	var loaded_car: Variant = data.get("car", DEFAULT_CAR_STATS)
	if typeof(loaded_car) == TYPE_DICTIONARY:
		car_stats = DEFAULT_CAR_STATS.duplicate(true)
		for key in car_stats.keys():
			car_stats[key] = int((loaded_car as Dictionary).get(key, car_stats[key]))
	else:
		car_stats = DEFAULT_CAR_STATS.duplicate(true)

	set_heat(heat)
	add_rep(0)
	add_cash(0)
