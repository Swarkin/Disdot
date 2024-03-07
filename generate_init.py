from pyperclip import copy

script = 'func _init(d: Dictionary) -> void:\n'
variables = ''

while True:
	content = input()+'\n'
	if content == '\n':
		break
	else:
		variables += content


for line in variables.strip().split('\n'):
	var_name = line.split('var ')[1].split(': ')[0]
	var_type = line.split(': ')[1]
	var_default = "''" if var_type == 'String' \
	        else '0' if var_type == 'int' \
	        else 'false' if var_type == 'bool' \
	        else '[]' if (var_type.startswith('Array') or var_type.startswith('Packed')) \
	        else '{}' if var_type.startswith('Dictionary') \
	        else 'null'

	script += f"	{var_name} = _safe_get(d, '{var_name}', {var_default}) as {var_type}"+'\n'

copy(script)
