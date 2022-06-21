# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "SYS_FREQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_MS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_SPEED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WIDTH_TIK" -parent ${Page_0}


}

proc update_PARAM_VALUE.SYS_FREQ { PARAM_VALUE.SYS_FREQ } {
	# Procedure called to update SYS_FREQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SYS_FREQ { PARAM_VALUE.SYS_FREQ } {
	# Procedure called to validate SYS_FREQ
	return true
}

proc update_PARAM_VALUE.WIDTH_MS { PARAM_VALUE.WIDTH_MS } {
	# Procedure called to update WIDTH_MS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_MS { PARAM_VALUE.WIDTH_MS } {
	# Procedure called to validate WIDTH_MS
	return true
}

proc update_PARAM_VALUE.WIDTH_SPEED { PARAM_VALUE.WIDTH_SPEED } {
	# Procedure called to update WIDTH_SPEED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_SPEED { PARAM_VALUE.WIDTH_SPEED } {
	# Procedure called to validate WIDTH_SPEED
	return true
}

proc update_PARAM_VALUE.WIDTH_TIK { PARAM_VALUE.WIDTH_TIK } {
	# Procedure called to update WIDTH_TIK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WIDTH_TIK { PARAM_VALUE.WIDTH_TIK } {
	# Procedure called to validate WIDTH_TIK
	return true
}


proc update_MODELPARAM_VALUE.WIDTH_TIK { MODELPARAM_VALUE.WIDTH_TIK PARAM_VALUE.WIDTH_TIK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_TIK}] ${MODELPARAM_VALUE.WIDTH_TIK}
}

proc update_MODELPARAM_VALUE.WIDTH_MS { MODELPARAM_VALUE.WIDTH_MS PARAM_VALUE.WIDTH_MS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_MS}] ${MODELPARAM_VALUE.WIDTH_MS}
}

proc update_MODELPARAM_VALUE.WIDTH_SPEED { MODELPARAM_VALUE.WIDTH_SPEED PARAM_VALUE.WIDTH_SPEED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WIDTH_SPEED}] ${MODELPARAM_VALUE.WIDTH_SPEED}
}

proc update_MODELPARAM_VALUE.SYS_FREQ { MODELPARAM_VALUE.SYS_FREQ PARAM_VALUE.SYS_FREQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SYS_FREQ}] ${MODELPARAM_VALUE.SYS_FREQ}
}

