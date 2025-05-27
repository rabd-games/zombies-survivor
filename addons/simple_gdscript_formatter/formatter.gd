class_name Formatter

const RuleBlankLines = preload("./rules/blank_lines.gd")
const RuleSpacing = preload("./rules/spacing.gd")

func format_code(code: String) -> String:
	code = RuleBlankLines.apply(code)
	code = RuleSpacing.apply(code)
	return code
