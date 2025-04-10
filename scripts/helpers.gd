class_name Helpers


static func has_ignore_case(dict: Dictionary, key: String) -> bool:
	var upper_key := key.to_upper()
	for k in dict.keys():
		if str(k).to_upper() == upper_key:
			return true
	return false
