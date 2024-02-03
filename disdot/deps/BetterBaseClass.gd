extends RefCounted
class_name BetterBaseClass
## BetterBaseClass v1.1.1 by swark1n

func _init(dict: Dictionary) -> void:
	for key: String in dict:
		@warning_ignore('inference_on_variant')
		var other_value := dict.get(key)
		var other_value_type := typeof(other_value)

		if other_value_type == TYPE_NIL:
			print_rich('[color=khaki]Received null value from key \'', key, '\'.[/color]')
			continue

		# Check if property is present in self
		if not key in self:
			print_rich('[color=khaki]Unknown key \'', key, '\' with value \'', other_value, '\' of type \'', type_string(other_value_type), '\'.[/color]')
			continue

		@warning_ignore('inference_on_variant')
		var self_value := self[key] as Variant
		var self_value_type := typeof(self_value)
		#assert(self_value_type == TYPE_NIL)

		# Check if the types match
		if not other_value_type == self_value_type:
			# Try to convert float to int (JSON decodes int values as float)
			if other_value_type == TYPE_FLOAT and self_value_type == TYPE_INT:
				print_rich('[color=khaki]Converting key \'', key, '\' with value \'', other_value, '\' from type \'', type_string(other_value_type), '\' to \'', type_string(self_value_type), '\'.[/color]')
				other_value = type_convert(other_value, self_value_type)
			else:
				print_rich('[color=khaki]Incompatible type of \'', key, '\' with value \'', other_value, '\' type \'', type_string(other_value_type), '\', expected type \'', type_string(self_value_type), '\'.[/color]')
				continue

		# Check if array has the correct type
		if self_value_type == TYPE_ARRAY:
			@warning_ignore('unsafe_method_access', 'unsafe_cast') var self_arr_type := self_value.get_typed_builtin() as Variant.Type
			@warning_ignore('unsafe_method_access', 'unsafe_cast') var other_arr_type := other_value.get_typed_builtin() as Variant.Type
			if not self_arr_type == other_arr_type:
				print_rich('[color=khaki]Incompatible array type: expected \'', type_string(self_arr_type), '\', got \'', type_string(other_arr_type), '\'.[/color]')
				continue

		# Finally:
		self[key] = dict[key]

func _to_string() -> String:
	const SEP := ', '
	var s := (get_script() as Script).get_global_name()+': '
	var p_list := get_property_list()

	for p in p_list:
		if p.get('usage') == PROPERTY_USAGE_SCRIPT_VARIABLE:
			s += p.get('name')+' = '+str(self[p.get('name')])+SEP

	return s.trim_suffix(SEP)
