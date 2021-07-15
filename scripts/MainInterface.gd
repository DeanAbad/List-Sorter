extends Control

onready var guideText : String  = "Write any integer and press the Enter key to add it in the array.\n\nAny texts that are not integer, such as newline (Return) and letter/s,\nwould only return a zero (0) as integer.\n\nAdditionally, since it only takes a 64bit type integer,\nit can only accept values from -2^63 to 2^63 - 1,\nin other words, from -9223372036854775808 to 9223372036854775807.\n\nThe given list shows the values according to the time they were entered.\n\nThe shuffled list displays shuffled values within the list.\n\nThe sorted list presents the sorted items according to their values."

onready var givenList : Array = []
onready var shuffledList : Array = []
onready var sortedList : Array = []

onready var autoAddEnabled : bool

onready var origin : int = 0

onready var negativeLimitSet : int
onready var positiveLimitSet : int

onready var windowNLimVisible : bool
onready var windowPLimVisible : bool

onready var nMinVal : int
onready var pMaxVal : int

func _ready() -> void:
	autoAddEnabled = false
	windowNLimVisible = true
	windowPLimVisible = true
	nMinVal = 0
	pMaxVal = 0

	textEditNodeSettings()
	vBoxContainerNodeSettings()
	textsNodeSettings()
	currentTextNodeSettings()
	guideNodeSettings()
	autoAddBtnNodeSettings()
	hSliderNodeSettings()
	rangeLegendNodeSettings()
	windowDialogNLimNodeSettings(windowNLimVisible, windowPLimVisible)
	optionButtonLimNodeSettings()

	rangeLegendNNodeSettings(nMinVal)
	rangeLegendPNodeSettings(pMaxVal)

	hSliderNNodeSettings(nMinVal)
	hSliderPNodeSettings(pMaxVal)

	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_text(
		"Shuffled List: " + str(shuffledList)
	)

	self.get_node("WindowDialogNLim/OptionButtonNLim")._select_int(0)
	self.get_node("WindowDialogPLim/OptionButtonPLim")._select_int(0)


func textEditNodeSettings() -> void:
	self.get_node("TextEdit").set_highlight_current_line(true)
	self.get_node("TextEdit")._set_anchor(MARGIN_LEFT, 0.033)
	self.get_node("TextEdit")._set_anchor(MARGIN_TOP, 0.771)
	self.get_node("TextEdit")._set_anchor(MARGIN_RIGHT, 0.787)
	self.get_node("TextEdit")._set_anchor(MARGIN_BOTTOM, 0.892)
	self.get_node("TextEdit").set_global_position(Vector2(20.0, 370.08))
	self.get_node("TextEdit")._set_size(Vector2(452.4, 58.08))


func vBoxContainerNodeSettings() -> void:
	self.get_node("TextList/VBoxContainer").set_alignment(BoxContainer.ALIGN_CENTER)
	self.get_node("TextList/VBoxContainer").set_size(Vector2(560.0, 305.0), false)


func textsNodeSettings() -> void:
	# Texts01 (Given List)
	self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_align(Label.ALIGN_FILL)
	self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_valign(Label.VALIGN_CENTER)
	self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_autowrap(true)
	self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_h_size_flags(3)
	self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_v_size_flags(3)

	# Texts02 (Shuffled List)
	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_align(Label.ALIGN_FILL)
	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_valign(Label.VALIGN_CENTER)
	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_autowrap(true)
	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_h_size_flags(3)
	self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_v_size_flags(3)

	# Texts03 (Sorted List)
	self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_align(Label.ALIGN_FILL)
	self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_valign(Label.VALIGN_CENTER)
	self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_autowrap(true)
	self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_h_size_flags(3)
	self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_v_size_flags(3)


func currentTextNodeSettings() -> void:
	self.get_node("CurrentText").set_use_bbcode(true)
	self.get_node("CurrentText").set_meta_underline(false)
	self.get_node("CurrentText").set_scroll_active(false)
	self.get_node("CurrentText")._set_anchor(MARGIN_LEFT, 0.033)
	self.get_node("CurrentText")._set_anchor(MARGIN_TOP, 0.734)
	self.get_node("CurrentText")._set_anchor(MARGIN_RIGHT, 0.967)
	self.get_node("CurrentText")._set_anchor(MARGIN_BOTTOM, 0.757)
	self.get_node("CurrentText")._set_position(Vector2(20.0, 352.0))
	self.get_node("CurrentText").set_size(Vector2(560.0, 12.0), false)

	if self.get_node("TextEdit").get_text() != "":
		self.get_node("CurrentText").set_bbcode(
			"Current Text: [shake rate=10 level=10][color=lime]" + str(
				int(
					self.get_node("TextEdit").text
				)
			) + "[/color][/shake]"
		)

	if self.get_node("TextEdit").get_text() == "":
		self.get_node("CurrentText").set_bbcode(
			"Current Text: [shake rate=10 level=10][color=red]empty[/color][/shake]"
		)


func guideNodeSettings() -> void:
	self.get_node("Guide").set_text("[?]")
	self.get_node("Guide").set_tooltip(guideText)
	self.get_node("Guide").set_mouse_filter(Control.MOUSE_FILTER_PASS)
	self.get_node("Guide").set_default_cursor_shape(Control.CURSOR_HELP)
	self.get_node("Guide").set_pass_on_modal_close_click(false)


func autoAddBtnNodeSettings() -> void:
	self.get_node("AutoAddBtn/AutoAddMode").set_use_bbcode(true)
	self.get_node("AutoAddBtn/AutoAddMode").set_meta_underline(false)
	self.get_node("AutoAddBtn/AutoAddMode").set_scroll_active(false)

	if autoAddEnabled == true:
		self.get_node("AutoAddBtn/AutoAddMode").set_bbcode(
			"[center]Auto Add\n[color=lime]ON[/color][/center]"
		)
	if autoAddEnabled == false:
		self.get_node("AutoAddBtn/AutoAddMode").set_bbcode(
			"[center]Auto Add\n[color=red]OFF[/color][/center]"
		)


func hSliderNodeSettings() -> void:
	# Negative HSlider
	self.get_node("NegativeHSlider")._set_anchor(MARGIN_LEFT, 0.033)
	self.get_node("NegativeHSlider")._set_anchor(MARGIN_TOP, 0.9)
	self.get_node("NegativeHSlider")._set_anchor(MARGIN_RIGHT, 0.498)
	self.get_node("NegativeHSlider")._set_anchor(MARGIN_BOTTOM, 0.933)
	self.get_node("NegativeHSlider")._set_position(Vector2(20.0, 432.0))
	self.get_node("NegativeHSlider").set_size(Vector2(279.4, 16.0), false)

	#self.get_node("NegativeHSlider").set_min(nMinVal)
	self.get_node("NegativeHSlider").set_max(origin)
	self.get_node("NegativeHSlider").set_value(origin)

	# Positive HSlider
	self.get_node("PositiveHSlider")._set_anchor(MARGIN_LEFT, 0.502)
	self.get_node("PositiveHSlider")._set_anchor(MARGIN_TOP, 0.9)
	self.get_node("PositiveHSlider")._set_anchor(MARGIN_RIGHT, 0.967)
	self.get_node("PositiveHSlider")._set_anchor(MARGIN_BOTTOM, 0.933)
	self.get_node("PositiveHSlider")._set_position(Vector2(301.0, 432.0))
	self.get_node("PositiveHSlider").set_size(Vector2(279.4, 16.0), false)
	
	self.get_node("PositiveHSlider").set_min(origin)
	#self.get_node("PositiveHSlider").set_max(pMaxVal)
	self.get_node("PositiveHSlider").set_value(origin)


func hSliderNNodeSettings(nMinIndex : int) -> void:
	var nMinValue = int(self.get_node("WindowDialogNLim/OptionButtonNLim").get_item_text(nMinIndex))
	self.get_node("NegativeHSlider").set_min(nMinValue)


func hSliderPNodeSettings(pMaxIndex : int) -> void:
	var pMaxValue = int(self.get_node("WindowDialogPLim/OptionButtonPLim").get_item_text(pMaxIndex))
	self.get_node("PositiveHSlider").set_max(pMaxValue)


func rangeLegendNodeSettings() -> void:
	# RangeOptionNBtn/RangeLegendN (Negative)
	self.get_node("RangeOptionNBtn/RangeLegendN").set_use_bbcode(true)
	self.get_node("RangeOptionNBtn/RangeLegendN").set_meta_underline(false)
	self.get_node("RangeOptionNBtn/RangeLegendN").set_scroll_active(false)
	self.get_node("RangeOptionNBtn/RangeLegendN").set_fit_content_height(true)

	# RangeOptionNBtn/RangeLegendN (Negative)
	self.get_node("RangeLegendO").bbcode_enabled = true
	self.get_node("RangeLegendO").meta_underlined = false
	self.get_node("RangeLegendO").scroll_active = false
	self.get_node("RangeLegendO").fit_content_height = true
	self.get_node("RangeLegendO").set_bbcode(
		"[center]0[/center]"
	)

	# RangeOptionNBtn/RangeLegendN (Negative)
	self.get_node("RangeOptionPBtn/RangeLegendP").set_use_bbcode(true)
	self.get_node("RangeOptionPBtn/RangeLegendP").set_meta_underline(false)
	self.get_node("RangeOptionPBtn/RangeLegendP").set_scroll_active(false)
	self.get_node("RangeOptionPBtn/RangeLegendP").set_fit_content_height(true)


func windowDialogNLimNodeSettings(thisVisibleN : bool, thisVisibleP : bool) -> void:
	# Negative Window Dialog Options Limit
	self.get_node("WindowDialogNLim").set_visible(thisVisibleN)
	self.get_node("WindowDialogNLim").set_title("Negative Limit")
	self.get_node("WindowDialogNLim").set_resizable(false)
	self.get_node("WindowDialogNLim").set_exclusive(true)
	self.get_node("WindowDialogNLim")._set_anchor(MARGIN_LEFT, 0.033)
	self.get_node("WindowDialogNLim")._set_anchor(MARGIN_TOP, 0.69)
	self.get_node("WindowDialogNLim")._set_anchor(MARGIN_RIGHT, 0.475)
	self.get_node("WindowDialogNLim")._set_anchor(MARGIN_BOTTOM, 0.89)

	# Positive Window Dialog Options Limit
	self.get_node("WindowDialogPLim").set_visible(thisVisibleP)
	self.get_node("WindowDialogPLim").set_title("Positive Limit")
	self.get_node("WindowDialogPLim").set_resizable(false)
	self.get_node("WindowDialogPLim").set_exclusive(true)
	self.get_node("WindowDialogPLim")._set_anchor(MARGIN_LEFT, 0.525)
	self.get_node("WindowDialogPLim")._set_anchor(MARGIN_TOP, 0.69)
	self.get_node("WindowDialogPLim")._set_anchor(MARGIN_RIGHT, 0.967)
	self.get_node("WindowDialogPLim")._set_anchor(MARGIN_BOTTOM, 0.89)


func optionButtonLimNodeSettings() -> void:
	var stringValueInitial : String = "1"
	var stringZeroDigit : String = "0"

	for totalDigit in 13:
		stringValueInitial += stringZeroDigit

		# Negative Limit Options
		self.get_node("WindowDialogNLim/OptionButtonNLim").add_item("-" + stringValueInitial, totalDigit)

		# Positive Limit Options
		self.get_node("WindowDialogPLim/OptionButtonPLim").add_item(stringValueInitial, totalDigit)


func rangeLegendNNodeSettings(nMinIndex : int) -> void:
	var nMinValue = int(self.get_node("WindowDialogNLim/OptionButtonNLim").get_item_text(nMinIndex))
	self.get_node("RangeOptionNBtn/RangeLegendN").set_bbcode(
		"[center]" + str(nMinValue) + "[/center]"
	)


func rangeLegendPNodeSettings(pMaxIndex : int) -> void:
	var pMaxValue = int(self.get_node("WindowDialogPLim/OptionButtonPLim").get_item_text(pMaxIndex))
	self.get_node("RangeOptionPBtn/RangeLegendP").set_bbcode(
		"[center]" + str(pMaxValue) + "[/center]"
	)


func _process(_delta) -> void:
		self.get_node("TextList/VBoxContainer/HBoxContainer1/Texts01").set_text(
			"Given List: " + str(givenList)
		)
		self.get_node("TextList/VBoxContainer/HBoxContainer3/Texts03").set_text(
			"Sorted List: " + str(sortedList)
		)

		self.get_node("NegativeHSlider").set_tooltip(
			str(
				int(
					self.get_node("NegativeHSlider").value
				)
			)
		)
		self.get_node("PositiveHSlider").set_tooltip(
			str(
				int(
					self.get_node("PositiveHSlider").value
				)
			)
		)

		if autoAddEnabled == true:
			self.get_node("CurrentText").set_bbcode(
				"Current Text: [shake rate=10 level=10][color=aqua]" + str(
					int(
						self.get_node("TextEdit").text
					)
				) + "[/color][/shake]"
			)
			pushInt(autoAddEnabled,
				self.get_node("TextEdit").text
			)
			shuffleInt(shuffledList)
			sortInt(sortedList)
			shuffleIntText()


func _input(event) -> void:
	if event.is_action_pressed("Enter"):
		pushInt(autoAddEnabled,
			self.get_node("TextEdit").text
		)
		shuffleInt(shuffledList)
		sortInt(sortedList)
		shuffleIntText()


func pushInt(thisRandomized : bool, thisInt : String) -> void:
	if thisRandomized == true:
		self.get_node("TextEdit").set_text(
			str(
				rand_range(
					negativeLimitSet,
					positiveLimitSet
				)
			)
		)
	if thisRandomized == false:
		self.get_node("TextEdit").set_text("")
	var currentInt = int(
		self.get_node("TextEdit").text + thisInt
	)
	givenList.push_front(currentInt)


func shuffleInt(thisShuffle : Array) -> void:
	thisShuffle = givenList.duplicate(true)
	thisShuffle.shuffle()
	shuffledList = thisShuffle


func sortInt(thisArray : Array) -> void:
	thisArray = shuffledList.duplicate(true)
	thisArray.sort()
	sortedList = thisArray


func shuffleIntText() -> void:
		self.get_node("TextList/VBoxContainer/HBoxContainer2/Texts02").set_text(
			"Shuffled List: " + str(shuffledList)
		)


func _on_TextEdit_text_changed() -> void:
	if self.get_node("TextEdit").text != "":
		self.get_node("CurrentText").set_bbcode(
			"Current Text: [shake rate=10 level=10][color=lime]" +
			str(
				int(
					self.get_node("TextEdit").text
				)
			) + "[/color][/shake]")

	if self.get_node("TextEdit").text == "":
		self.get_node("CurrentText").set_bbcode(
			"Current Text: [shake rate=10 level=10][color=red]empty[/color][/shake]"
		)


func _on_AutoAddBtn_pressed() -> void:
	autoAddEnabled = !autoAddEnabled

	shuffleInt(shuffledList)
	sortInt(sortedList)
	shuffleIntText()

	self.get_node("CurrentText").set_bbcode(
		"Current Text: [shake rate=10 level=10][color=lime]" + str(
			int(
				self.get_node("TextEdit").text
			)
		) + "[/color][/shake]"
	)

	if autoAddEnabled == true:
		self.get_node("AutoAddBtn/AutoAddMode").set_bbcode(
			"[center]Auto Add\n[color=lime]ON[/color][/center]"
		)
	if autoAddEnabled == false:
		self.get_node("AutoAddBtn/AutoAddMode").set_bbcode(
			"[center]Auto Add\n[color=red]OFF[/color][/center]"
		)


func _on_NegativeHSlider_value_changed(thisValue : int) -> void:
	negativeLimitSet = thisValue


func _on_PositiveHSlider_value_changed(thisValue : int) -> void:
	positiveLimitSet = thisValue


func _on_RangeOptionNBtn_pressed():
	windowNLimVisible = !windowNLimVisible
	windowPLimVisible = windowPLimVisible
	windowDialogNLimNodeSettings(windowNLimVisible, windowPLimVisible)


func _on_RangeOptionPBtn_pressed():
	windowPLimVisible = !windowPLimVisible
	windowNLimVisible = windowNLimVisible
	windowDialogNLimNodeSettings(windowNLimVisible, windowPLimVisible)


func _on_OptionButtonNLim_item_selected(thisIndex : int) -> void:
	hSliderNNodeSettings(thisIndex)
	rangeLegendNNodeSettings(thisIndex)


func _on_OptionButtonPLim_item_selected(thisIndex : int) -> void:
	hSliderPNodeSettings(thisIndex)
	rangeLegendPNodeSettings(thisIndex)
