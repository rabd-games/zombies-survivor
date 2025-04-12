
class_name RuleBlankLines


static func apply(code: String) -> String:
	var trim1_regex = RegEx.create_from_string("\n{2,}")
	code = trim1_regex.sub(code, "\n\n", true)
	var blank_regex := RegEx.create_from_string(r"(.*\s?(func|class)\s.*)")
	code = blank_regex.sub(code, "\n\n\n$1", true)
	var trim2_regex = RegEx.create_from_string("\n{3,}")
	code = trim2_regex.sub(code, "\n\n\n", true)
	return code
