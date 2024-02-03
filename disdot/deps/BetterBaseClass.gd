extends RefCounted
class_name BetterBaseClass
## BetterBaseClass Class v1.0.0 by swark1n

func _init(dict: Dictionary) -> void:
	for key: String in dict:
		@warning_ignore('inference_on_variant')
		var other_value := dict.get(key)
		var other_value_type := typeof(other_value)

		if other_value_type == TYPE_NIL:
			push_warning('Received null value from key \'', key, '\'.')
			continue

		# Check if property is present in self
		if not key in self:
			push_warning('Received unknown key \'', key, '\' with value \'', other_value, '\' of type \'', other_value_type, '\'.')
			continue

		@warning_ignore('inference_on_variant')
		var self_value := self[key] as Variant
		var self_value_type := typeof(self_value)
		#assert(self_value_type == TYPE_NIL)

		# Check if the types match
		if not other_value_type == self_value_type:
			push_warning('Incompatible type of \'', key, '\' with value \'', other_value, '\' type \'', other_value_type, '\', expected type \'', self_value_type, '\'.')
			continue

		# Check if array has the correct type
		if self_value_type == TYPE_ARRAY:
			@warning_ignore('unsafe_method_access', 'unsafe_cast') var self_arr_type := self_value.get_typed_builtin() as Variant.Type
			@warning_ignore('unsafe_method_access', 'unsafe_cast') var other_arr_type := other_value.get_typed_builtin() as Variant.Type
			if not self_arr_type == other_arr_type:
				push_warning('Incompatible array type: expected \'', self_arr_type, '\', got \'', other_arr_type, '\'.')
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
