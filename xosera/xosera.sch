(kicad_sch
	(version 20250114)
	(generator "eeschema")
	(generator_version "9.0")
	(uuid "147ce174-3047-45a2-8664-38025ac4f072")
	(paper "A4")
	(title_block
		(title "Xosera <-> M68k Bus Interface")
		(date "2021-10-22")
		(rev "p1")
		(comment 1 "UPduino + PMOD to m68k bus")
		(comment 2 "Copyright ©2021 Xark and Contributors")
	)
	(lib_symbols
		(symbol "74xx:74LS245"
			(pin_names
				(offset 1.016)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "U"
				(at -7.62 16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "74LS245"
				(at -7.62 -16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "http://www.ti.com/lit/gpn/sn74LS245"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Octal BUS Transceivers, 3-State outputs"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_locked" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "TTL BUS 3State"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "DIP?20*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "74LS245_1_0"
				(polyline
					(pts
						(xy -1.27 -1.27) (xy 0.635 -1.27) (xy 0.635 1.27) (xy 1.27 1.27)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -0.635 -1.27) (xy -0.635 1.27) (xy 0.635 1.27)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(pin tri_state line
					(at -12.7 12.7 0)
					(length 5.08)
					(name "A0"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 10.16 0)
					(length 5.08)
					(name "A1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 7.62 0)
					(length 5.08)
					(name "A2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 5.08 0)
					(length 5.08)
					(name "A3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 2.54 0)
					(length 5.08)
					(name "A4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 0 0)
					(length 5.08)
					(name "A5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 -2.54 0)
					(length 5.08)
					(name "A6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at -12.7 -5.08 0)
					(length 5.08)
					(name "A7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -10.16 0)
					(length 5.08)
					(name "A->B"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input inverted
					(at -12.7 -12.7 0)
					(length 5.08)
					(name "CE"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin power_in line
					(at 0 20.32 270)
					(length 5.08)
					(name "VCC"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin power_in line
					(at 0 -20.32 90)
					(length 5.08)
					(name "GND"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 12.7 180)
					(length 5.08)
					(name "B0"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 10.16 180)
					(length 5.08)
					(name "B1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 7.62 180)
					(length 5.08)
					(name "B2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 5.08 180)
					(length 5.08)
					(name "B3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 2.54 180)
					(length 5.08)
					(name "B4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 0 180)
					(length 5.08)
					(name "B5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -2.54 180)
					(length 5.08)
					(name "B6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -5.08 180)
					(length 5.08)
					(name "B7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "74LS245_1_1"
				(rectangle
					(start -7.62 15.24)
					(end 7.62 -15.24)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "74xx:74LS74"
			(pin_names
				(offset 1.016)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "U"
				(at -7.62 8.89 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "74LS74"
				(at -7.62 -8.89 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "74xx/74hc_hct74.pdf"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Dual D Flip-flop, Set & Reset"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_locked" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "ki_keywords" "TTL DFF"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "DIP*W7.62mm*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "74LS74_1_0"
				(pin input line
					(at -7.62 2.54 0)
					(length 2.54)
					(name "D"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input clock
					(at -7.62 0 0)
					(length 2.54)
					(name "C"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at 0 7.62 270)
					(length 2.54)
					(name "~{S}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at 0 -7.62 90)
					(length 2.54)
					(name "~{R}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin output line
					(at 7.62 2.54 180)
					(length 2.54)
					(name "Q"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin output line
					(at 7.62 -2.54 180)
					(length 2.54)
					(name "~{Q}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "74LS74_1_1"
				(rectangle
					(start -5.08 5.08)
					(end 5.08 -5.08)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "74LS74_2_0"
				(pin input line
					(at -7.62 2.54 0)
					(length 2.54)
					(name "D"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input clock
					(at -7.62 0 0)
					(length 2.54)
					(name "C"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at 0 7.62 270)
					(length 2.54)
					(name "~{S}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at 0 -7.62 90)
					(length 2.54)
					(name "~{R}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin output line
					(at 7.62 2.54 180)
					(length 2.54)
					(name "Q"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin output line
					(at 7.62 -2.54 180)
					(length 2.54)
					(name "~{Q}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "74LS74_2_1"
				(rectangle
					(start -5.08 5.08)
					(end 5.08 -5.08)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "74LS74_3_0"
				(pin power_in line
					(at 0 10.16 270)
					(length 2.54)
					(name "VCC"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin power_in line
					(at 0 -10.16 90)
					(length 2.54)
					(name "GND"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "74LS74_3_1"
				(rectangle
					(start -5.08 7.62)
					(end 5.08 -7.62)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector:Conn_01x06_Male"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 0 7.62 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Connector_Conn_01x06_Male"
				(at 0 -10.16 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_1x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_01x06_Male_1_1"
				(rectangle
					(start 0.8636 5.207)
					(end 0 4.953)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 2.667)
					(end 0 2.413)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 0.127)
					(end 0 -0.127)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -2.413)
					(end 0 -2.667)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -4.953)
					(end 0 -5.207)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -7.493)
					(end 0 -7.747)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(polyline
					(pts
						(xy 1.27 5.08) (xy 0.8636 5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 2.54) (xy 0.8636 2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 0) (xy 0.8636 0)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -2.54) (xy 0.8636 -2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -5.08) (xy 0.8636 -5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -7.62) (xy 0.8636 -7.62)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at 5.08 5.08 180)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 2.54 180)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 0 180)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -2.54 180)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -5.08 180)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -7.62 180)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector:Conn_01x08_Male"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 0 10.16 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Connector_Conn_01x08_Male"
				(at 0 -12.7 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_1x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_01x08_Male_1_1"
				(rectangle
					(start 0.8636 7.747)
					(end 0 7.493)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 5.207)
					(end 0 4.953)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 2.667)
					(end 0 2.413)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 0.127)
					(end 0 -0.127)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -2.413)
					(end 0 -2.667)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -4.953)
					(end 0 -5.207)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -7.493)
					(end 0 -7.747)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(rectangle
					(start 0.8636 -10.033)
					(end 0 -10.287)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
				(polyline
					(pts
						(xy 1.27 7.62) (xy 0.8636 7.62)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 5.08) (xy 0.8636 5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 2.54) (xy 0.8636 2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 0) (xy 0.8636 0)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -2.54) (xy 0.8636 -2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -5.08) (xy 0.8636 -5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -7.62) (xy 0.8636 -7.62)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -10.16) (xy 0.8636 -10.16)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at 5.08 7.62 180)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 5.08 180)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 2.54 180)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 0 180)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -2.54 180)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -5.08 180)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -7.62 180)
					(length 3.81)
					(name "Pin_7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 5.08 -10.16 180)
					(length 3.81)
					(name "Pin_8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector:Conn_01x24_Female"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 0 30.48 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Connector_Conn_01x24_Female"
				(at 0 -33.02 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_1x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_01x24_Female_1_1"
				(polyline
					(pts
						(xy -1.27 27.94) (xy -0.508 27.94)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 25.4) (xy -0.508 25.4)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 22.86) (xy -0.508 22.86)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 20.32) (xy -0.508 20.32)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 17.78) (xy -0.508 17.78)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 15.24) (xy -0.508 15.24)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 12.7) (xy -0.508 12.7)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 10.16) (xy -0.508 10.16)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 7.62) (xy -0.508 7.62)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 5.08) (xy -0.508 5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 2.54) (xy -0.508 2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 0) (xy -0.508 0)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -2.54) (xy -0.508 -2.54)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -5.08) (xy -0.508 -5.08)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -7.62) (xy -0.508 -7.62)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -10.16) (xy -0.508 -10.16)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -12.7) (xy -0.508 -12.7)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -15.24) (xy -0.508 -15.24)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -17.78) (xy -0.508 -17.78)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -20.32) (xy -0.508 -20.32)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -22.86) (xy -0.508 -22.86)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -25.4) (xy -0.508 -25.4)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -27.94) (xy -0.508 -27.94)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 -30.48) (xy -0.508 -30.48)
					)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 27.432)
					(mid -0.508 27.94)
					(end 0 28.448)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 24.892)
					(mid -0.508 25.4)
					(end 0 25.908)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 22.352)
					(mid -0.508 22.86)
					(end 0 23.368)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 19.812)
					(mid -0.508 20.32)
					(end 0 20.828)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 17.272)
					(mid -0.508 17.78)
					(end 0 18.288)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 14.732)
					(mid -0.508 15.24)
					(end 0 15.748)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 12.192)
					(mid -0.508 12.7)
					(end 0 13.208)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 9.652)
					(mid -0.508 10.16)
					(end 0 10.668)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 7.112)
					(mid -0.508 7.62)
					(end 0 8.128)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 4.572)
					(mid -0.508 5.08)
					(end 0 5.588)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 2.032)
					(mid -0.508 2.54)
					(end 0 3.048)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -0.508)
					(mid -0.508 0)
					(end 0 0.508)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -3.048)
					(mid -0.508 -2.54)
					(end 0 -2.032)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -5.588)
					(mid -0.508 -5.08)
					(end 0 -4.572)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -8.128)
					(mid -0.508 -7.62)
					(end 0 -7.112)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -10.668)
					(mid -0.508 -10.16)
					(end 0 -9.652)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -13.208)
					(mid -0.508 -12.7)
					(end 0 -12.192)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -15.748)
					(mid -0.508 -15.24)
					(end 0 -14.732)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -18.288)
					(mid -0.508 -17.78)
					(end 0 -17.272)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -20.828)
					(mid -0.508 -20.32)
					(end 0 -19.812)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -23.368)
					(mid -0.508 -22.86)
					(end 0 -22.352)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -25.908)
					(mid -0.508 -25.4)
					(end 0 -24.892)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -28.448)
					(mid -0.508 -27.94)
					(end 0 -27.432)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start 0 -30.988)
					(mid -0.508 -30.48)
					(end 0 -29.972)
					(stroke
						(width 0.1524)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at -5.08 27.94 0)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 25.4 0)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 22.86 0)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 20.32 0)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 17.78 0)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 15.24 0)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 12.7 0)
					(length 3.81)
					(name "Pin_7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 10.16 0)
					(length 3.81)
					(name "Pin_8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 7.62 0)
					(length 3.81)
					(name "Pin_9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 5.08 0)
					(length 3.81)
					(name "Pin_10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 2.54 0)
					(length 3.81)
					(name "Pin_11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 0 0)
					(length 3.81)
					(name "Pin_12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -2.54 0)
					(length 3.81)
					(name "Pin_13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -5.08 0)
					(length 3.81)
					(name "Pin_14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -7.62 0)
					(length 3.81)
					(name "Pin_15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -10.16 0)
					(length 3.81)
					(name "Pin_16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -12.7 0)
					(length 3.81)
					(name "Pin_17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -15.24 0)
					(length 3.81)
					(name "Pin_18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -17.78 0)
					(length 3.81)
					(name "Pin_19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -20.32 0)
					(length 3.81)
					(name "Pin_20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -22.86 0)
					(length 3.81)
					(name "Pin_21"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "21"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -25.4 0)
					(length 3.81)
					(name "Pin_22"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "22"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -27.94 0)
					(length 3.81)
					(name "Pin_23"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "23"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -30.48 0)
					(length 3.81)
					(name "Pin_24"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "24"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector_Generic:Conn_02x04_Counter_Clockwise"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 1.27 5.08 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Conn_02x04_Counter_Clockwise"
				(at 1.27 -7.62 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Generic connector, double row, 02x04, counter clockwise pin numbering scheme (similar to DIP package numbering), script generated (kicad-library-utils/schlib/autogen/connector/)"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "connector"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_2x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_02x04_Counter_Clockwise_1_1"
				(rectangle
					(start -1.27 3.81)
					(end 3.81 -6.35)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
				(rectangle
					(start -1.27 2.667)
					(end 0 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 0.127)
					(end 0 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -2.413)
					(end 0 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -4.953)
					(end 0 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 2.667)
					(end 2.54 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 0.127)
					(end 2.54 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -2.413)
					(end 2.54 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -4.953)
					(end 2.54 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at -5.08 2.54 0)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 0 0)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -2.54 0)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -5.08 0)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 2.54 180)
					(length 3.81)
					(name "Pin_8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 0 180)
					(length 3.81)
					(name "Pin_7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -2.54 180)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -5.08 180)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector_Generic:Conn_02x06_Odd_Even"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 1.27 7.62 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Conn_02x06_Odd_Even"
				(at 1.27 -10.16 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Generic connector, double row, 02x06, odd/even pin numbering scheme (row 1 odd numbers, row 2 even numbers), script generated (kicad-library-utils/schlib/autogen/connector/)"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "connector"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_2x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_02x06_Odd_Even_1_1"
				(rectangle
					(start -1.27 6.35)
					(end 3.81 -8.89)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
				(rectangle
					(start -1.27 5.207)
					(end 0 4.953)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 2.667)
					(end 0 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 0.127)
					(end 0 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -2.413)
					(end 0 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -4.953)
					(end 0 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -7.493)
					(end 0 -7.747)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 5.207)
					(end 2.54 4.953)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 2.667)
					(end 2.54 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 0.127)
					(end 2.54 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -2.413)
					(end 2.54 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -4.953)
					(end 2.54 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -7.493)
					(end 2.54 -7.747)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at -5.08 5.08 0)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 2.54 0)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 0 0)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -2.54 0)
					(length 3.81)
					(name "Pin_7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -5.08 0)
					(length 3.81)
					(name "Pin_9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -7.62 0)
					(length 3.81)
					(name "Pin_11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 5.08 180)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 2.54 180)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 0 180)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -2.54 180)
					(length 3.81)
					(name "Pin_8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -5.08 180)
					(length 3.81)
					(name "Pin_10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -7.62 180)
					(length 3.81)
					(name "Pin_12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Connector_Generic:Conn_02x32_Odd_Even"
			(pin_names
				(offset 1.016)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "J"
				(at 1.27 40.64 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Conn_02x32_Odd_Even"
				(at 1.27 -43.18 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Generic connector, double row, 02x32, odd/even pin numbering scheme (row 1 odd numbers, row 2 even numbers), script generated (kicad-library-utils/schlib/autogen/connector/)"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "connector"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "Connector*:*_2x??_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Conn_02x32_Odd_Even_1_1"
				(rectangle
					(start -1.27 39.37)
					(end 3.81 -41.91)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
				(rectangle
					(start -1.27 38.227)
					(end 0 37.973)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 35.687)
					(end 0 35.433)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 33.147)
					(end 0 32.893)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 30.607)
					(end 0 30.353)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 28.067)
					(end 0 27.813)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 25.527)
					(end 0 25.273)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 22.987)
					(end 0 22.733)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 20.447)
					(end 0 20.193)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 17.907)
					(end 0 17.653)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 15.367)
					(end 0 15.113)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 12.827)
					(end 0 12.573)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 10.287)
					(end 0 10.033)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 7.747)
					(end 0 7.493)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 5.207)
					(end 0 4.953)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 2.667)
					(end 0 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 0.127)
					(end 0 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -2.413)
					(end 0 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -4.953)
					(end 0 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -7.493)
					(end 0 -7.747)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -10.033)
					(end 0 -10.287)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -12.573)
					(end 0 -12.827)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -15.113)
					(end 0 -15.367)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -17.653)
					(end 0 -17.907)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -20.193)
					(end 0 -20.447)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -22.733)
					(end 0 -22.987)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -25.273)
					(end 0 -25.527)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -27.813)
					(end 0 -28.067)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -30.353)
					(end 0 -30.607)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -32.893)
					(end 0 -33.147)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -35.433)
					(end 0 -35.687)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -37.973)
					(end 0 -38.227)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start -1.27 -40.513)
					(end 0 -40.767)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 38.227)
					(end 2.54 37.973)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 35.687)
					(end 2.54 35.433)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 33.147)
					(end 2.54 32.893)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 30.607)
					(end 2.54 30.353)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 28.067)
					(end 2.54 27.813)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 25.527)
					(end 2.54 25.273)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 22.987)
					(end 2.54 22.733)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 20.447)
					(end 2.54 20.193)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 17.907)
					(end 2.54 17.653)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 15.367)
					(end 2.54 15.113)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 12.827)
					(end 2.54 12.573)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 10.287)
					(end 2.54 10.033)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 7.747)
					(end 2.54 7.493)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 5.207)
					(end 2.54 4.953)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 2.667)
					(end 2.54 2.413)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 0.127)
					(end 2.54 -0.127)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -2.413)
					(end 2.54 -2.667)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -4.953)
					(end 2.54 -5.207)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -7.493)
					(end 2.54 -7.747)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -10.033)
					(end 2.54 -10.287)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -12.573)
					(end 2.54 -12.827)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -15.113)
					(end 2.54 -15.367)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -17.653)
					(end 2.54 -17.907)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -20.193)
					(end 2.54 -20.447)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -22.733)
					(end 2.54 -22.987)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -25.273)
					(end 2.54 -25.527)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -27.813)
					(end 2.54 -28.067)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -30.353)
					(end 2.54 -30.607)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -32.893)
					(end 2.54 -33.147)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -35.433)
					(end 2.54 -35.687)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -37.973)
					(end 2.54 -38.227)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 3.81 -40.513)
					(end 2.54 -40.767)
					(stroke
						(width 0.1524)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at -5.08 38.1 0)
					(length 3.81)
					(name "Pin_1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 35.56 0)
					(length 3.81)
					(name "Pin_3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 33.02 0)
					(length 3.81)
					(name "Pin_5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 30.48 0)
					(length 3.81)
					(name "Pin_7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 27.94 0)
					(length 3.81)
					(name "Pin_9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 25.4 0)
					(length 3.81)
					(name "Pin_11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 22.86 0)
					(length 3.81)
					(name "Pin_13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 20.32 0)
					(length 3.81)
					(name "Pin_15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 17.78 0)
					(length 3.81)
					(name "Pin_17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 15.24 0)
					(length 3.81)
					(name "Pin_19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 12.7 0)
					(length 3.81)
					(name "Pin_21"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "21"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 10.16 0)
					(length 3.81)
					(name "Pin_23"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "23"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 7.62 0)
					(length 3.81)
					(name "Pin_25"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "25"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 5.08 0)
					(length 3.81)
					(name "Pin_27"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "27"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 2.54 0)
					(length 3.81)
					(name "Pin_29"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "29"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 0 0)
					(length 3.81)
					(name "Pin_31"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "31"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -2.54 0)
					(length 3.81)
					(name "Pin_33"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "33"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -5.08 0)
					(length 3.81)
					(name "Pin_35"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "35"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -7.62 0)
					(length 3.81)
					(name "Pin_37"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "37"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -10.16 0)
					(length 3.81)
					(name "Pin_39"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "39"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -12.7 0)
					(length 3.81)
					(name "Pin_41"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "41"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -15.24 0)
					(length 3.81)
					(name "Pin_43"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "43"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -17.78 0)
					(length 3.81)
					(name "Pin_45"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "45"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -20.32 0)
					(length 3.81)
					(name "Pin_47"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "47"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -22.86 0)
					(length 3.81)
					(name "Pin_49"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "49"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -25.4 0)
					(length 3.81)
					(name "Pin_51"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "51"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -27.94 0)
					(length 3.81)
					(name "Pin_53"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "53"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -30.48 0)
					(length 3.81)
					(name "Pin_55"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "55"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -33.02 0)
					(length 3.81)
					(name "Pin_57"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "57"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -35.56 0)
					(length 3.81)
					(name "Pin_59"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "59"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -38.1 0)
					(length 3.81)
					(name "Pin_61"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "61"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at -5.08 -40.64 0)
					(length 3.81)
					(name "Pin_63"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "63"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 38.1 180)
					(length 3.81)
					(name "Pin_2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 35.56 180)
					(length 3.81)
					(name "Pin_4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 33.02 180)
					(length 3.81)
					(name "Pin_6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 30.48 180)
					(length 3.81)
					(name "Pin_8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 27.94 180)
					(length 3.81)
					(name "Pin_10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 25.4 180)
					(length 3.81)
					(name "Pin_12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 22.86 180)
					(length 3.81)
					(name "Pin_14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 20.32 180)
					(length 3.81)
					(name "Pin_16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 17.78 180)
					(length 3.81)
					(name "Pin_18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 15.24 180)
					(length 3.81)
					(name "Pin_20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 12.7 180)
					(length 3.81)
					(name "Pin_22"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "22"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 10.16 180)
					(length 3.81)
					(name "Pin_24"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "24"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 7.62 180)
					(length 3.81)
					(name "Pin_26"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "26"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 5.08 180)
					(length 3.81)
					(name "Pin_28"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "28"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 2.54 180)
					(length 3.81)
					(name "Pin_30"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "30"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 0 180)
					(length 3.81)
					(name "Pin_32"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "32"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -2.54 180)
					(length 3.81)
					(name "Pin_34"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "34"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -5.08 180)
					(length 3.81)
					(name "Pin_36"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "36"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -7.62 180)
					(length 3.81)
					(name "Pin_38"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "38"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -10.16 180)
					(length 3.81)
					(name "Pin_40"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "40"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -12.7 180)
					(length 3.81)
					(name "Pin_42"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "42"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -15.24 180)
					(length 3.81)
					(name "Pin_44"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "44"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -17.78 180)
					(length 3.81)
					(name "Pin_46"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "46"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -20.32 180)
					(length 3.81)
					(name "Pin_48"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "48"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -22.86 180)
					(length 3.81)
					(name "Pin_50"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "50"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -25.4 180)
					(length 3.81)
					(name "Pin_52"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "52"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -27.94 180)
					(length 3.81)
					(name "Pin_54"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "54"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -30.48 180)
					(length 3.81)
					(name "Pin_56"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "56"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -33.02 180)
					(length 3.81)
					(name "Pin_58"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "58"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -35.56 180)
					(length 3.81)
					(name "Pin_60"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "60"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -38.1 180)
					(length 3.81)
					(name "Pin_62"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "62"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 -40.64 180)
					(length 3.81)
					(name "Pin_64"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "64"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Device:C"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0.254)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "C"
				(at 0.635 2.54 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "C"
				(at 0.635 -2.54 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0.9652 -3.81 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Unpolarized capacitor"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "cap capacitor"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "C_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "C_0_1"
				(polyline
					(pts
						(xy -2.032 0.762) (xy 2.032 0.762)
					)
					(stroke
						(width 0.508)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -2.032 -0.762) (xy 2.032 -0.762)
					)
					(stroke
						(width 0.508)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "C_1_1"
				(pin passive line
					(at 0 3.81 270)
					(length 2.794)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -3.81 90)
					(length 2.794)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Device:CP"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0.254)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "C"
				(at 0.635 2.54 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "Device_CP"
				(at 0.635 -2.54 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0.9652 -3.81 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "CP_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "CP_0_1"
				(rectangle
					(start -2.286 0.508)
					(end 2.286 1.016)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.778 2.286) (xy -0.762 2.286)
					)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy -1.27 2.794) (xy -1.27 1.778)
					)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(rectangle
					(start 2.286 -0.508)
					(end -2.286 -1.016)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type outline)
					)
				)
			)
			(symbol "CP_1_1"
				(pin passive line
					(at 0 3.81 270)
					(length 2.794)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -3.81 90)
					(length 2.794)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Device:Jumper"
			(pin_names
				(offset 0.762)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "JP"
				(at 0 3.81 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "Device_Jumper"
				(at 0 -2.032 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "SolderJumper*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "Jumper_0_1"
				(circle
					(center -2.54 0)
					(radius 0.889)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(arc
					(start -2.4892 1.27)
					(mid 0.0077 2.4896)
					(end 2.5146 1.27)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(circle
					(center 2.54 0)
					(radius 0.889)
					(stroke
						(width 0)
						(type solid)
					)
					(fill
						(type none)
					)
				)
				(pin passive line
					(at -7.62 0 0)
					(length 4.191)
					(name "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 7.62 0 180)
					(length 4.191)
					(name "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Device:R"
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "R"
				(at 2.032 0 90)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Value" "R"
				(at 0 0 90)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at -1.778 0 90)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Resistor"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "R res resistor"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "R_*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "R_0_1"
				(rectangle
					(start -1.016 -2.54)
					(end 1.016 2.54)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "R_1_1"
				(pin passive line
					(at 0 3.81 270)
					(length 1.27)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 0 -3.81 90)
					(length 1.27)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Logic_Programmable:GAL16V8"
			(pin_names
				(offset 1.016)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "U"
				(at -8.89 16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "GAL16V8"
				(at 1.27 16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Programmable Logic Array, DIP-20/SOIC-20/PLCC-20"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "GAL PLD 16V8"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "DIP* PDIP* SOIC* SO* PLCC*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "GAL16V8_0_0"
				(pin power_in line
					(at 0 17.78 270)
					(length 3.81)
					(name "VCC"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin power_in line
					(at 0 -17.78 90)
					(length 3.81)
					(name "GND"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "GAL16V8_0_1"
				(rectangle
					(start -8.89 13.97)
					(end 8.89 -13.97)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "GAL16V8_1_1"
				(pin input line
					(at -12.7 12.7 0)
					(length 3.81)
					(name "I1/CLK"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 10.16 0)
					(length 3.81)
					(name "I2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 7.62 0)
					(length 3.81)
					(name "I3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 5.08 0)
					(length 3.81)
					(name "I4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 2.54 0)
					(length 3.81)
					(name "I5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 0 0)
					(length 3.81)
					(name "I6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -2.54 0)
					(length 3.81)
					(name "I7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -5.08 0)
					(length 3.81)
					(name "I8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -7.62 0)
					(length 3.81)
					(name "I9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -10.16 0)
					(length 3.81)
					(name "I10/~{OE}"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 12.7 180)
					(length 3.81)
					(name "IO1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 10.16 180)
					(length 3.81)
					(name "IO2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 7.62 180)
					(length 3.81)
					(name "I03"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 5.08 180)
					(length 3.81)
					(name "IO4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 2.54 180)
					(length 3.81)
					(name "IO5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 0 180)
					(length 3.81)
					(name "IO6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -2.54 180)
					(length 3.81)
					(name "IO7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -5.08 180)
					(length 3.81)
					(name "IO8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "Transistor_BJT:2N3904"
			(pin_names
				(offset 0)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "Q"
				(at 5.08 1.905 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "2N3904"
				(at 5.08 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" "Package_TO_SOT_THT:TO-92_Inline"
				(at 5.08 -1.905 0)
				(effects
					(font
						(size 1.27 1.27)
						(italic yes)
					)
					(justify left)
					(hide yes)
				)
			)
			(property "Datasheet" "https://www.onsemi.com/pub/Collateral/2N3903-D.PDF"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
					(hide yes)
				)
			)
			(property "Description" "0.2A Ic, 40V Vce, Small Signal NPN Transistor, TO-92"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "NPN Transistor"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "TO?92*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "2N3904_0_1"
				(polyline
					(pts
						(xy -2.54 0) (xy 0.635 0)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 0.635 1.905) (xy 0.635 -1.905)
					)
					(stroke
						(width 0.508)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(circle
					(center 1.27 0)
					(radius 2.8194)
					(stroke
						(width 0.254)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "2N3904_1_1"
				(polyline
					(pts
						(xy 0.635 0.635) (xy 2.54 2.54)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 0.635 -0.635) (xy 2.54 -2.54)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
				(polyline
					(pts
						(xy 1.27 -1.778) (xy 1.778 -1.27) (xy 2.286 -2.286) (xy 1.27 -1.778)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type outline)
					)
				)
				(pin input line
					(at -5.08 0 0)
					(length 2.54)
					(name "B"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 2.54 5.08 270)
					(length 2.54)
					(name "C"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin passive line
					(at 2.54 -5.08 90)
					(length 2.54)
					(name "E"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "power:GND"
			(power)
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "#PWR"
				(at 0 -6.35 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Value" "GND"
				(at 0 -3.81 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Power symbol creates a global label with name \"GND\" , ground"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "global power"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "GND_0_1"
				(polyline
					(pts
						(xy 0 0) (xy 0 -1.27) (xy 1.27 -1.27) (xy 0 -2.54) (xy -1.27 -1.27) (xy 0 -1.27)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(symbol "GND_1_1"
				(pin power_in line
					(at 0 0 270)
					(length 0)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "power:PWR_FLAG"
			(power)
			(pin_numbers
				(hide yes)
			)
			(pin_names
				(offset 0)
				(hide yes)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "#FLG"
				(at 0 1.905 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Value" "PWR_FLAG"
				(at 0 3.81 0)
				(effects
					(font
						(size 1.27 1.27)
					)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" "~"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" "Special symbol for telling ERC where power comes from"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_keywords" "flag power"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "PWR_FLAG_0_0"
				(pin power_out line
					(at 0 0 90)
					(length 0)
					(name "~"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "PWR_FLAG_0_1"
				(polyline
					(pts
						(xy 0 0) (xy 0 1.27) (xy -1.016 1.905) (xy 0 2.54) (xy 1.016 1.905) (xy 0 1.27)
					)
					(stroke
						(width 0)
						(type default)
					)
					(fill
						(type none)
					)
				)
			)
			(embedded_fonts no)
		)
		(symbol "rosco_m68k:GAL22V10"
			(pin_names
				(offset 1.016)
			)
			(exclude_from_sim no)
			(in_bom yes)
			(on_board yes)
			(property "Reference" "IC"
				(at -8.89 16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Value" "rosco_m68k_GAL22V10"
				(at 1.27 16.51 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(justify left)
				)
			)
			(property "Footprint" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Datasheet" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "Description" ""
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(property "ki_fp_filters" "DIP* PDIP* SOIC* SO* PLCC*"
				(at 0 0 0)
				(effects
					(font
						(size 1.27 1.27)
					)
					(hide yes)
				)
			)
			(symbol "GAL22V10_0_0"
				(pin power_in line
					(at 0 17.78 270)
					(length 3.81)
					(name "VCC"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "24"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin power_in line
					(at 0 -17.78 90)
					(length 3.81)
					(name "GND"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "12"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(symbol "GAL22V10_0_1"
				(rectangle
					(start -8.89 13.97)
					(end 8.89 -13.97)
					(stroke
						(width 0.254)
						(type solid)
					)
					(fill
						(type background)
					)
				)
			)
			(symbol "GAL22V10_1_1"
				(pin input line
					(at -12.7 12.7 0)
					(length 3.81)
					(name "I1/CLK"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 10.16 0)
					(length 3.81)
					(name "I2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 7.62 0)
					(length 3.81)
					(name "I3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 5.08 0)
					(length 3.81)
					(name "I4/PD"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "4"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 2.54 0)
					(length 3.81)
					(name "I5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 0 0)
					(length 3.81)
					(name "I6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -2.54 0)
					(length 3.81)
					(name "I7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -5.08 0)
					(length 3.81)
					(name "I8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -7.62 0)
					(length 3.81)
					(name "I9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -10.16 0)
					(length 3.81)
					(name "I10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at -12.7 -12.7 0)
					(length 3.81)
					(name "I11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "11"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 12.7 180)
					(length 3.81)
					(name "IO10"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "23"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 10.16 180)
					(length 3.81)
					(name "IO9"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "22"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 7.62 180)
					(length 3.81)
					(name "IO8"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "21"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 5.08 180)
					(length 3.81)
					(name "IO7"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "20"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 2.54 180)
					(length 3.81)
					(name "IO6"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "19"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 0 180)
					(length 3.81)
					(name "IO5"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "18"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -2.54 180)
					(length 3.81)
					(name "I04"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "17"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -5.08 180)
					(length 3.81)
					(name "IO3"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "16"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -7.62 180)
					(length 3.81)
					(name "IO2"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "15"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin tri_state line
					(at 12.7 -10.16 180)
					(length 3.81)
					(name "IO1"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "14"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
				(pin input line
					(at 12.7 -12.7 180)
					(length 3.81)
					(name "I13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
					(number "13"
						(effects
							(font
								(size 1.27 1.27)
							)
						)
					)
				)
			)
			(embedded_fonts no)
		)
	)
	(text "All BUS_xxx signals are 3V3\nUpduino-compatible signals"
		(exclude_from_sim no)
		(at 137.16 19.05 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "0cbb41a0-9dff-4408-aeb0-4f2bcf246c59")
	)
	(text "VGA/HDMI RIGHT"
		(exclude_from_sim no)
		(at 219.71 52.07 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right bottom)
		)
		(uuid "1b187cf9-907b-4f7f-ac69-f167d73f845b")
	)
	(text "USB TOP"
		(exclude_from_sim no)
		(at 154.94 29.21 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right bottom)
		)
		(uuid "52f6babf-a973-4bc4-ac2f-1edd00920097")
	)
	(text "IC3 - DECODER"
		(exclude_from_sim no)
		(at 217.17 153.67 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "5a153dce-1c7b-4110-bbff-986dc6f21a3b")
	)
	(text "FPGA_R is /RnW"
		(exclude_from_sim no)
		(at 121.92 151.13 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right bottom)
		)
		(uuid "5c0907cc-a441-4f39-a926-597705a566b9")
	)
	(text "All 470R"
		(exclude_from_sim no)
		(at 95.25 142.24 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "7288c742-6eec-43f1-9628-db8ecc61037a")
	)
	(text "Note - Inverted layout!"
		(exclude_from_sim no)
		(at 31.75 106.68 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "9c6f9088-d5b7-43d4-b2b7-a3a2f835c6b6")
	)
	(text "UD_IRQ is active high!\nGlue latches into IC6 on \nrising edge."
		(exclude_from_sim no)
		(at 162.56 38.1 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "a0297909-bc3f-414c-864d-7c289ec4c5cc")
	)
	(text "Upduino 3.0\nRGB Jumper Cut\nOSC Jumper Shorted"
		(exclude_from_sim no)
		(at 142.24 95.25 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "a845fc3b-b9c5-495c-bf03-452f13dc0511")
	)
	(text "IC4 - GLUE"
		(exclude_from_sim no)
		(at 171.45 153.67 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left bottom)
		)
		(uuid "b4aee102-8973-472f-b401-28be2db7e0b1")
	)
	(junction
		(at 105.41 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "0f5c7acd-ba9b-4762-8f97-e10747626489")
	)
	(junction
		(at 95.25 97.79)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "1d4ab6a5-9ef0-47cb-ab1d-5869c8e45c3e")
	)
	(junction
		(at 29.21 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "2108b93a-0f50-4fa2-a9c2-feb19a54a1d0")
	)
	(junction
		(at 46.99 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "241c44d4-8fef-4122-b803-0c9e331603d8")
	)
	(junction
		(at 146.05 157.48)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "25753e44-f742-4a9c-9038-012c6e8667ff")
	)
	(junction
		(at 99.06 157.48)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "26f0b90b-a39c-4969-8e0c-9d3a88490499")
	)
	(junction
		(at 20.32 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "3fdbd906-0f7b-4542-8cf5-e15ea4f15ce2")
	)
	(junction
		(at 55.88 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "40e5cd25-8a44-40d4-a7d1-379903b55016")
	)
	(junction
		(at 66.04 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "44bb8bef-664f-416b-8a3c-1b9499d5f62e")
	)
	(junction
		(at 55.88 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "45ddde00-efec-4664-bc55-12b8748346a0")
	)
	(junction
		(at 38.1 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "4712adaa-0ac0-4093-be9f-ab9cfeabebe6")
	)
	(junction
		(at 119.38 48.26)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "495ef863-a0a5-403c-a763-8b704ce0a73f")
	)
	(junction
		(at 179.07 115.57)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "54f65fe1-54f2-40ba-a6f2-829b24516fef")
	)
	(junction
		(at 179.07 157.48)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "578bc3a6-964c-4ec4-bd85-01b3c14769da")
	)
	(junction
		(at 74.93 88.9)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "5a8c5bac-2d19-4c01-8e89-fd6c5d853a84")
	)
	(junction
		(at 76.2 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "5f563ec6-8497-4c2e-b2d6-a060f11a32b3")
	)
	(junction
		(at -77.47 90.17)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "78fc33c6-1938-4f95-8811-2e63313e0402")
	)
	(junction
		(at 38.1 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "79caa18d-d97d-4922-b73b-73dfee3e11cd")
	)
	(junction
		(at 29.21 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "976333af-a151-401f-bafe-92c4c3f05c9c")
	)
	(junction
		(at 46.99 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "9cbe09b1-4c51-4f05-a0d8-09c19f574b17")
	)
	(junction
		(at 87.63 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "9e16fc48-37db-4c8e-9db6-feea990d5230")
	)
	(junction
		(at 76.2 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "a02a3036-dfc5-4392-8753-89073116ef3f")
	)
	(junction
		(at 80.01 157.48)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "b0266ff4-5378-4bbf-b4b1-0b041ec97bc5")
	)
	(junction
		(at 105.41 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "b42edb0b-14e1-4476-8a23-ed12db7635d6")
	)
	(junction
		(at 118.11 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "c8b5bd5e-7036-42ac-b466-4c19872f7c2e")
	)
	(junction
		(at 133.35 157.48)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "d9d8775f-a1d8-46d1-ba3b-367d4d40f4e2")
	)
	(junction
		(at 270.51 31.75)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "db4afb8e-2463-4287-8e93-3ea66205777f")
	)
	(junction
		(at 66.04 186.69)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "e25e816a-2a58-4b30-b3c8-3933d2498fb4")
	)
	(junction
		(at 271.78 31.75)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "e34fb2ca-740b-4b7d-8b59-5b005b847484")
	)
	(junction
		(at 118.11 168.91)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "eadccc88-c8e4-4abf-aae9-823a62e69f74")
	)
	(junction
		(at 133.35 113.03)
		(diameter 0)
		(color 0 0 0 0)
		(uuid "f331debb-4ec1-468d-ad3e-8164620e4f94")
	)
	(no_connect
		(at -72.39 180.34)
		(uuid "03a65ccc-f03f-4e08-b71b-a798d5281d54")
	)
	(no_connect
		(at -59.69 180.34)
		(uuid "05fa0871-8204-4280-a3dc-221871f70dc5")
	)
	(no_connect
		(at -59.69 190.5)
		(uuid "07ff72c3-a55b-4ac5-875d-6600c61780c1")
	)
	(no_connect
		(at 139.7 30.48)
		(uuid "1114ee8c-4b59-4136-8b39-d611ded13ea8")
	)
	(no_connect
		(at -72.39 132.08)
		(uuid "13f8a23e-e310-4d8a-8679-20aa9edd1808")
	)
	(no_connect
		(at -50.8 87.63)
		(uuid "161a6188-8612-49e5-9123-1c4e17b124f5")
	)
	(no_connect
		(at -59.69 154.94)
		(uuid "272064ed-e353-45c1-b4cd-e97b76a77885")
	)
	(no_connect
		(at -72.39 190.5)
		(uuid "28966611-362f-4f31-93ea-9b8d1d84fe38")
	)
	(no_connect
		(at 139.7 35.56)
		(uuid "30bc5caa-dd19-44ab-8dee-bc8c2dd2304e")
	)
	(no_connect
		(at -50.8 64.77)
		(uuid "35a288a9-ff64-4e49-abe2-e5666e8be563")
	)
	(no_connect
		(at -50.8 54.61)
		(uuid "39494b85-d6cc-4502-a638-cac58902e734")
	)
	(no_connect
		(at -72.39 177.8)
		(uuid "3a2ebbd0-8c5c-42af-b324-800dc44ff238")
	)
	(no_connect
		(at 161.29 45.72)
		(uuid "414ac5fe-7275-4a01-a144-8dbabae69e56")
	)
	(no_connect
		(at -59.69 172.72)
		(uuid "4287fa81-6fa2-4ddf-bb52-595ddc9c9355")
	)
	(no_connect
		(at -63.5 11.43)
		(uuid "45427797-d940-4b79-a04a-5da4f218b710")
	)
	(no_connect
		(at 161.29 33.02)
		(uuid "493cabdf-120c-454c-b863-0002c9c4cd39")
	)
	(no_connect
		(at -50.8 62.23)
		(uuid "527f6dc5-a495-469f-81cd-4041660c4d97")
	)
	(no_connect
		(at -63.5 21.59)
		(uuid "5a5a48c8-9d4b-4c98-bb13-95a542604097")
	)
	(no_connect
		(at -59.69 177.8)
		(uuid "5e3e600e-a522-4bb5-b66e-5b7071ae93a3")
	)
	(no_connect
		(at -50.8 57.15)
		(uuid "61e6e15f-fe28-4bcb-a93b-8a4390c6ec81")
	)
	(no_connect
		(at -63.5 26.67)
		(uuid "643c52e7-b5b0-41e5-a0a6-c89f2889b604")
	)
	(no_connect
		(at -50.8 67.31)
		(uuid "681dfb73-b25f-45b0-a1c6-6458694c60ea")
	)
	(no_connect
		(at -59.69 167.64)
		(uuid "72177878-2f8c-464e-b697-5f435737f015")
	)
	(no_connect
		(at -59.69 187.96)
		(uuid "76752874-c7e8-465f-a82e-e88b80c07c38")
	)
	(no_connect
		(at -72.39 121.92)
		(uuid "7b5181ef-1b0f-4ca4-9432-8f408e5095dd")
	)
	(no_connect
		(at 124.46 102.87)
		(uuid "8088c2a7-e4ae-4bea-acc0-c92eecef56e1")
	)
	(no_connect
		(at 191.77 143.51)
		(uuid "80e47f1e-c4cb-4497-b38d-f87d6b937541")
	)
	(no_connect
		(at 161.29 35.56)
		(uuid "81e2330e-a96b-4e13-aa9b-e7cd1aab263b")
	)
	(no_connect
		(at -63.5 19.05)
		(uuid "8259e19d-c883-4b79-a239-f82530eae794")
	)
	(no_connect
		(at -72.39 185.42)
		(uuid "8cdcdae9-c0ab-4a00-92ff-337e5b2bccbd")
	)
	(no_connect
		(at 161.29 27.94)
		(uuid "8eb1b505-a643-4027-867c-97215ca1464a")
	)
	(no_connect
		(at 161.29 30.48)
		(uuid "8f09a2e3-a36a-4a2e-b798-61ae38db4d0a")
	)
	(no_connect
		(at 191.77 146.05)
		(uuid "8fbaa28a-22c7-4af1-b877-79d497f5fbc5")
	)
	(no_connect
		(at -63.5 13.97)
		(uuid "90dbae84-955c-4136-8b42-7e5da04806ca")
	)
	(no_connect
		(at -72.39 182.88)
		(uuid "91e838bd-d102-4b6d-a778-7fac984082ad")
	)
	(no_connect
		(at -59.69 162.56)
		(uuid "94748b32-8426-4ec7-a8ad-38980bda77be")
	)
	(no_connect
		(at -72.39 147.32)
		(uuid "96b55804-450e-460e-9711-6bd46b94b1f6")
	)
	(no_connect
		(at -58.42 210.82)
		(uuid "978b98a2-e517-4514-b000-194cb48f0b12")
	)
	(no_connect
		(at -72.39 127)
		(uuid "a2e268ab-e33e-4f97-9787-aaa79c617f68")
	)
	(no_connect
		(at -59.69 165.1)
		(uuid "ab3fd10a-1976-43f7-9977-f6866ed02918")
	)
	(no_connect
		(at -72.39 142.24)
		(uuid "aed32667-9546-44eb-af74-1d527e627950")
	)
	(no_connect
		(at 191.77 125.73)
		(uuid "af724c57-d730-4976-8839-2d76b96e33e4")
	)
	(no_connect
		(at 191.77 135.89)
		(uuid "b36d71ed-89fa-4a11-adbc-87c1048db94c")
	)
	(no_connect
		(at 161.29 38.1)
		(uuid "c5035da4-e8d7-411d-a82d-ef032a694f51")
	)
	(no_connect
		(at -50.8 59.69)
		(uuid "c9b0b35f-4a4c-42c7-ae1c-052cd051c791")
	)
	(no_connect
		(at -59.69 157.48)
		(uuid "c9d78774-134e-4e6c-995a-618705befbd6")
	)
	(no_connect
		(at -59.69 160.02)
		(uuid "ce3e3906-ca39-47ad-b1c5-108f4b3c9ce5")
	)
	(no_connect
		(at -72.39 124.46)
		(uuid "d68aba3b-dda4-4a0b-b24b-b0f2b3805552")
	)
	(no_connect
		(at 124.46 97.79)
		(uuid "dd09f65e-7714-4852-9138-c34cd8d2ec77")
	)
	(no_connect
		(at 189.23 101.6)
		(uuid "eaaf0762-be7b-4a17-b1db-4544c21d51c7")
	)
	(no_connect
		(at -72.39 187.96)
		(uuid "f2bc4193-ff2a-4301-ac2b-9ee6ec0fae42")
	)
	(no_connect
		(at -63.5 16.51)
		(uuid "f3dabbcd-4e2d-4828-99dd-a65e20da1aa8")
	)
	(no_connect
		(at -50.8 85.09)
		(uuid "f4c02d1d-fb27-4a2e-b1a4-caa55b7d364c")
	)
	(no_connect
		(at -59.69 175.26)
		(uuid "f5621898-b90f-425f-9c5e-98d91cee319b")
	)
	(no_connect
		(at 236.22 138.43)
		(uuid "f75fa3bf-2e7b-4ef6-a664-31d074fcded6")
	)
	(no_connect
		(at -63.5 24.13)
		(uuid "f9b74e54-a9f5-460e-bea4-d80510bb5cd9")
	)
	(wire
		(pts
			(xy 118.11 173.99) (xy 118.11 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "00c52c82-9351-451d-9c2a-0d92c2f47626")
	)
	(wire
		(pts
			(xy 95.25 55.88) (xy 104.14 55.88)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "021a5d04-0406-415f-878e-00b5f26e3009")
	)
	(wire
		(pts
			(xy 66.04 168.91) (xy 76.2 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "03040bff-f7fb-4989-b08e-df05acf358e8")
	)
	(wire
		(pts
			(xy 80.01 113.03) (xy 88.9 113.03)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0574b385-3b37-484b-9eee-b91b5663311c")
	)
	(wire
		(pts
			(xy 38.1 168.91) (xy 29.21 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "05bc6855-e126-4464-8729-fd760e536670")
	)
	(wire
		(pts
			(xy 175.26 90.17) (xy 175.26 91.44)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0a4b438b-4728-4c66-950b-c6dde2d867d9")
	)
	(wire
		(pts
			(xy -33.02 83.82) (xy -33.02 80.01)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0adedbe4-1704-4bd3-98ca-03846440de21")
	)
	(wire
		(pts
			(xy 271.78 31.75) (xy 274.32 31.75)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0ae0c9cf-2288-41c9-86a5-653cc0f5eb1f")
	)
	(wire
		(pts
			(xy 38.1 173.99) (xy 38.1 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0c1fb0bf-b8a2-41d6-a306-2687ceab8a3d")
	)
	(wire
		(pts
			(xy 116.84 92.71) (xy 110.49 92.71)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "0ff9e08f-4119-4c73-a2a1-14a8552589ab")
	)
	(wire
		(pts
			(xy 74.93 97.79) (xy 95.25 97.79)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "10df7efd-ecdf-41ea-96e2-de004b3b36af")
	)
	(wire
		(pts
			(xy 88.9 113.03) (xy 88.9 110.49)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "1357c005-6dde-46c8-aafe-b5cdd7746231")
	)
	(wire
		(pts
			(xy 266.7 31.75) (xy 270.51 31.75)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "1a1f1a38-1490-40b1-afce-29d0626bbefc")
	)
	(wire
		(pts
			(xy 76.2 168.91) (xy 87.63 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "1a3919c1-2d7e-4e57-a56e-abb70890a32b")
	)
	(wire
		(pts
			(xy 130.81 168.91) (xy 118.11 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "1dd7773f-fee6-4428-9217-afe7bead1b66")
	)
	(wire
		(pts
			(xy 55.88 186.69) (xy 66.04 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "1e44e73e-e6b4-4df0-a8c3-2bc0a850bceb")
	)
	(wire
		(pts
			(xy 251.46 31.75) (xy 243.84 31.75)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "21340bfb-d2d6-44cc-a6a0-200dd320a418")
	)
	(wire
		(pts
			(xy 57.15 157.48) (xy 80.01 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "226292ca-20ec-4b9f-b62a-4c4d69e94a02")
	)
	(wire
		(pts
			(xy 92.71 138.43) (xy 95.25 138.43)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "24f185ce-3bf9-4028-af06-c37d3741e34a")
	)
	(wire
		(pts
			(xy 177.8 109.22) (xy 181.61 109.22)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "27b2cf65-c6f4-4eba-ad5f-37ea655ae18e")
	)
	(wire
		(pts
			(xy 118.11 186.69) (xy 130.81 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "29c3bb4e-c0fa-48a0-a9e3-d1337df7cc94")
	)
	(wire
		(pts
			(xy 74.93 86.36) (xy 74.93 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "2a9dc2cf-7e05-423c-b83d-b0d81c28e0ec")
	)
	(wire
		(pts
			(xy 92.71 123.19) (xy 95.25 123.19)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "2aaa148e-3e41-4109-b2c8-a04883d17a7f")
	)
	(wire
		(pts
			(xy 76.2 186.69) (xy 87.63 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "339cfca9-6e0f-43f3-b2f2-7bead7c8926a")
	)
	(wire
		(pts
			(xy -36.83 90.17) (xy -50.8 90.17)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "350b5ffa-67bd-42ae-a25e-0388236bd55a")
	)
	(wire
		(pts
			(xy 95.25 97.79) (xy 95.25 100.33)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "3a9ed46f-2ebf-4186-8d7c-e7f4eb71f539")
	)
	(wire
		(pts
			(xy 55.88 181.61) (xy 55.88 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "3f9519d4-8ecd-457a-b2fd-f964b0b5ecd4")
	)
	(wire
		(pts
			(xy 99.06 143.51) (xy 120.65 143.51)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "4052b88b-4ef6-469e-8cd5-871d46bc3cbd")
	)
	(wire
		(pts
			(xy 46.99 168.91) (xy 38.1 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "43ca5240-f350-48de-ba9c-d8f73c126174")
	)
	(wire
		(pts
			(xy 95.25 120.65) (xy 92.71 120.65)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "443d6472-bd25-46fa-a8ce-da3f87261dcf")
	)
	(wire
		(pts
			(xy 99.06 157.48) (xy 133.35 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "465de589-830d-46fb-807d-eb6f82f1dbbf")
	)
	(wire
		(pts
			(xy 82.55 88.9) (xy 74.93 88.9)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "476b7ede-f76f-4c35-a4b5-98221b56b79d")
	)
	(wire
		(pts
			(xy 171.45 115.57) (xy 179.07 115.57)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "49c0c7b0-e91b-4057-864c-cd572800a5bc")
	)
	(wire
		(pts
			(xy 76.2 181.61) (xy 76.2 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "4bc5db5b-549d-4182-9d3d-a9d6db1285d8")
	)
	(wire
		(pts
			(xy 247.65 73.66) (xy 251.46 73.66)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "507edea1-c557-46a9-9164-ec7a92b12044")
	)
	(wire
		(pts
			(xy 20.32 186.69) (xy 29.21 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "527e0651-5f60-44b1-b365-864d71ec8edb")
	)
	(wire
		(pts
			(xy 107.95 109.22) (xy 116.84 109.22)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "5383fd7b-1abd-46fb-8e35-91adbc130ad7")
	)
	(wire
		(pts
			(xy -33.02 80.01) (xy -50.8 80.01)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "5729a9a0-99bd-4e68-9ba6-3fd2e5493367")
	)
	(wire
		(pts
			(xy 251.46 21.59) (xy 243.84 21.59)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "5ac92d06-c1f3-4f99-80c4-906216799cb3")
	)
	(wire
		(pts
			(xy 105.41 186.69) (xy 105.41 190.5)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "5e07742f-d779-4d7b-96ec-e6898bcc535c")
	)
	(wire
		(pts
			(xy 38.1 181.61) (xy 38.1 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "68d95f3e-c209-4d94-a264-1e48f8e19b5f")
	)
	(wire
		(pts
			(xy 76.2 173.99) (xy 76.2 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "6d3d2297-97e0-4469-a9a0-944f04023574")
	)
	(wire
		(pts
			(xy 105.41 168.91) (xy 105.41 173.99)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "6dd85892-277a-47bd-b951-f4819b114978")
	)
	(wire
		(pts
			(xy 223.52 157.48) (xy 223.52 151.13)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "6f421eae-d2a5-4195-b970-9eead4ddb600")
	)
	(wire
		(pts
			(xy 55.88 173.99) (xy 55.88 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "7179b897-3e60-4d54-b8a9-e428268b95e9")
	)
	(wire
		(pts
			(xy 146.05 157.48) (xy 179.07 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "731ed698-9fe8-4660-9376-bb805cdd5c72")
	)
	(wire
		(pts
			(xy 104.14 55.88) (xy 104.14 53.34)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "73d225e1-fdcb-4d49-8d52-38fc40bc9503")
	)
	(wire
		(pts
			(xy 133.35 113.03) (xy 171.45 113.03)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "7858f73c-6aa8-49e2-8d64-4b2553a3842c")
	)
	(wire
		(pts
			(xy 266.7 21.59) (xy 274.32 21.59)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "78b489d5-54ec-4cf2-8f6f-f9564b067684")
	)
	(wire
		(pts
			(xy 57.15 143.51) (xy 67.31 143.51)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "7a08d7bf-eda3-45f7-bc71-d1a1c6e589e2")
	)
	(wire
		(pts
			(xy 80.01 157.48) (xy 99.06 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "7ccfd6d7-cf10-4b91-918b-fb6ee735ba30")
	)
	(wire
		(pts
			(xy 105.41 186.69) (xy 118.11 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "7f8489f1-1e01-4ddd-9991-38b8c895d08d")
	)
	(wire
		(pts
			(xy 74.93 88.9) (xy 74.93 97.79)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "85f41bda-3cb4-4d9e-bf1f-0b3409b63e73")
	)
	(wire
		(pts
			(xy 99.06 143.51) (xy 99.06 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "86189b41-ad9b-4523-b2e9-2557471cd03f")
	)
	(wire
		(pts
			(xy 270.51 43.18) (xy 270.51 31.75)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "87e0381f-c780-465a-8e75-f2e610a24a94")
	)
	(wire
		(pts
			(xy 57.15 143.51) (xy 57.15 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "8b3f9239-030b-4df6-8ece-cf84d679af9d")
	)
	(wire
		(pts
			(xy -77.47 90.17) (xy -63.5 90.17)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "8bcb74e2-f256-42a7-95db-1da1c334fcdd")
	)
	(wire
		(pts
			(xy 266.7 60.96) (xy 270.51 60.96)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "90c08caa-a1b8-4cdb-994e-55c38116f210")
	)
	(wire
		(pts
			(xy 55.88 168.91) (xy 46.99 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "91e01971-5dfd-4f69-94c8-b0095df208f4")
	)
	(wire
		(pts
			(xy 46.99 173.99) (xy 46.99 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "91f70e6a-c0a0-40bb-b976-6d68eea292e2")
	)
	(wire
		(pts
			(xy 82.55 86.36) (xy 74.93 86.36)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "93223c8b-99f3-406a-9c7c-d6be57117b22")
	)
	(wire
		(pts
			(xy 92.71 133.35) (xy 95.25 133.35)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "935cbfb9-1394-48c4-a86f-3b0d12c1c24b")
	)
	(wire
		(pts
			(xy 29.21 168.91) (xy 20.32 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "93645115-4c8c-4874-ad9c-41c5e7daccda")
	)
	(wire
		(pts
			(xy 179.07 157.48) (xy 223.52 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "9cea1df0-4dd1-47d9-ac6c-c1e8a65df1df")
	)
	(wire
		(pts
			(xy 46.99 186.69) (xy 55.88 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "9e052690-af63-454f-9e66-49ac6d9bf414")
	)
	(wire
		(pts
			(xy 92.71 125.73) (xy 95.25 125.73)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "9eea6710-23d1-48bb-ba28-560319c1e0eb")
	)
	(wire
		(pts
			(xy 80.01 153.67) (xy 80.01 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "a4329952-3314-427b-9241-16d2dbb03b9f")
	)
	(wire
		(pts
			(xy 171.45 113.03) (xy 171.45 115.57)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "a79bd949-d9fb-4f80-9545-a53227c48b0f")
	)
	(wire
		(pts
			(xy 133.35 157.48) (xy 146.05 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "a8c55ce1-f018-4ef0-b0f0-de7154fbb400")
	)
	(wire
		(pts
			(xy 175.26 91.44) (xy 181.61 91.44)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "ac5de70d-1a0d-48fa-b0b3-4cb2f1ceb4de")
	)
	(wire
		(pts
			(xy 118.11 186.69) (xy 118.11 181.61)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "acf6a16d-cdde-4dc7-9acf-d95e687315b5")
	)
	(wire
		(pts
			(xy 179.07 151.13) (xy 179.07 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "b2ec2dbe-221e-409e-bb58-6147374efd8c")
	)
	(wire
		(pts
			(xy 270.51 31.75) (xy 271.78 31.75)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "b3952105-6bd0-4c22-95b9-5303054e46d4")
	)
	(wire
		(pts
			(xy 105.41 181.61) (xy 105.41 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "b7084326-3f2d-449b-9df5-396c295909e9")
	)
	(wire
		(pts
			(xy 266.7 52.07) (xy 274.32 52.07)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "b8daf736-5b51-4413-b145-4b1255732db8")
	)
	(wire
		(pts
			(xy 110.49 92.71) (xy 110.49 91.44)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "bc015e58-1177-40cf-a11d-1a5fabb8ca96")
	)
	(wire
		(pts
			(xy 116.84 109.22) (xy 116.84 107.95)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c0540aea-cbdf-45b7-a66e-bbdd92617838")
	)
	(wire
		(pts
			(xy 29.21 181.61) (xy 29.21 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c197886c-212e-4b1b-8e0b-0a8e84d7482a")
	)
	(wire
		(pts
			(xy 133.35 153.67) (xy 133.35 157.48)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c5471efa-6316-4300-bab1-ccb9327858a4")
	)
	(wire
		(pts
			(xy 20.32 168.91) (xy 20.32 173.99)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "c5b734ea-bc14-415d-b293-352c8151f7e3")
	)
	(wire
		(pts
			(xy 92.71 135.89) (xy 95.25 135.89)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cc53e210-f616-4e56-9aae-f3461ac8a2be")
	)
	(wire
		(pts
			(xy 66.04 181.61) (xy 66.04 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cc69e170-7d4a-4a23-a5e2-0207003e29e3")
	)
	(wire
		(pts
			(xy 95.25 96.52) (xy 95.25 97.79)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cd181286-36ef-4ba6-94d8-cac9d64a6337")
	)
	(wire
		(pts
			(xy 66.04 186.69) (xy 76.2 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cd262392-01b0-4982-a963-3ac6bd4110e3")
	)
	(wire
		(pts
			(xy 29.21 186.69) (xy 38.1 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cd9f47a4-58e3-4e73-8e77-25651f586da2")
	)
	(wire
		(pts
			(xy 133.35 113.03) (xy 125.73 113.03)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "ced29ccf-1df3-44f6-82b9-efa7a2c68347")
	)
	(wire
		(pts
			(xy 119.38 48.26) (xy 139.7 48.26)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "cf2b8d31-0a64-4470-acc8-8f2a0e31135c")
	)
	(wire
		(pts
			(xy 55.88 168.91) (xy 66.04 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d2482c53-cf2e-4afe-a2cf-b2f0bfeeb607")
	)
	(wire
		(pts
			(xy 125.73 113.03) (xy 125.73 110.49)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d4f4710b-ce06-44ba-ad8c-62f2c2f9aa48")
	)
	(wire
		(pts
			(xy 251.46 43.18) (xy 243.84 43.18)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d6c1c44c-95b0-4a4e-9f4e-e6276f722fc3")
	)
	(wire
		(pts
			(xy 66.04 173.99) (xy 66.04 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d7a84a41-c808-414b-9498-d1f070760b0f")
	)
	(wire
		(pts
			(xy 38.1 186.69) (xy 46.99 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "d810ac8f-2863-49dc-a950-5ac1ef112022")
	)
	(wire
		(pts
			(xy 92.71 128.27) (xy 95.25 128.27)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "da927480-d613-4578-8c77-0ac24a76195f")
	)
	(wire
		(pts
			(xy 92.71 130.81) (xy 95.25 130.81)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e0eb70b2-bb98-4b31-98d8-69ffca152b32")
	)
	(wire
		(pts
			(xy 179.07 115.57) (xy 223.52 115.57)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e420c224-02a0-43c7-b148-39a11d4c8c10")
	)
	(wire
		(pts
			(xy 266.7 43.18) (xy 270.51 43.18)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e5de569c-cffa-45da-9cba-b40272cd79ed")
	)
	(wire
		(pts
			(xy -80.01 90.17) (xy -77.47 90.17)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e88c8271-5301-4eff-95f6-50d025c6cc99")
	)
	(wire
		(pts
			(xy 87.63 173.99) (xy 87.63 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e8e71497-1a3c-4de9-a0bd-c1c5ec4db5af")
	)
	(wire
		(pts
			(xy 20.32 181.61) (xy 20.32 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "e90d4c1e-7e53-4466-9e8a-c06c4ae6b2ec")
	)
	(wire
		(pts
			(xy 118.11 168.91) (xy 105.41 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "eb58b585-133a-4614-a655-b9350f0fe6ba")
	)
	(wire
		(pts
			(xy 247.65 60.96) (xy 251.46 60.96)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "ed7bcecc-2bf9-4cf8-8682-640e601b5ccd")
	)
	(wire
		(pts
			(xy 130.81 173.99) (xy 130.81 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "efc8d5ab-2f07-4ac7-b8af-a0226656ef2c")
	)
	(wire
		(pts
			(xy 116.84 48.26) (xy 119.38 48.26)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f1480734-bc9f-45ff-8eb6-38027fcdb838")
	)
	(wire
		(pts
			(xy 251.46 52.07) (xy 243.84 52.07)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f372aa53-9828-4be0-8667-489c46690780")
	)
	(wire
		(pts
			(xy 181.61 109.22) (xy 181.61 106.68)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f48dff09-17a9-4619-9f04-d527eb538234")
	)
	(wire
		(pts
			(xy 146.05 157.48) (xy 146.05 160.02)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f5de1368-a860-438e-b2ff-736e37999df8")
	)
	(wire
		(pts
			(xy 87.63 181.61) (xy 87.63 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f74ce6be-e425-4629-a3ce-2bb5f2a82ddc")
	)
	(wire
		(pts
			(xy 46.99 181.61) (xy 46.99 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f87b631b-3f32-4821-bd99-5baa7d3456a1")
	)
	(wire
		(pts
			(xy 105.41 165.1) (xy 105.41 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "f9c49c99-a0fa-43aa-b8a2-d0b62a88d523")
	)
	(wire
		(pts
			(xy 130.81 186.69) (xy 130.81 181.61)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "fcf66936-db3a-40f1-928b-4660e96934ec")
	)
	(wire
		(pts
			(xy 29.21 173.99) (xy 29.21 168.91)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "fd108f33-3117-45e3-9c22-42940ba02fe5")
	)
	(wire
		(pts
			(xy 105.41 186.69) (xy 87.63 186.69)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "fd3b2469-3f6b-4a6d-b85d-f298f298c7f4")
	)
	(wire
		(pts
			(xy 20.32 168.91) (xy 20.32 163.83)
		)
		(stroke
			(width 0)
			(type default)
		)
		(uuid "feb4f49b-cf60-45a4-b14e-84c11be1dbf6")
	)
	(global_label "VGA_G0"
		(shape output)
		(at 161.29 78.74 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0044ac6c-d183-4210-a4f0-daaeb3b951f5")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 78.74 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AS"
		(shape output)
		(at -59.69 170.18 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "00f6abc4-5b77-4129-9268-3f9c25e88e72")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -59.69 170.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D13"
		(shape input)
		(at 26.67 119.38 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0205528f-659d-4165-87b8-72eac5a0c17f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 119.38 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D15"
		(shape input)
		(at 102.87 120.65 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "027619c2-3937-404f-a67b-1d7bd54acfdc")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 101.6 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0337a8c2-828d-4e8b-861d-6402f51ed2f9")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 101.6 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 109.22 100.33 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "03966470-5533-4c02-971f-5117cbcb81a8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 109.22 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 274.32 31.75 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "041ce018-8a90-44d0-85da-553b1934dd08")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 274.32 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_VS"
		(shape input)
		(at 207.01 74.93 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0661e9d1-d3de-449b-b26e-582dd0971695")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 74.93 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA4"
		(shape output)
		(at 67.31 128.27 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "06914932-5b63-417d-b3b0-ad70ffb20362")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA0"
		(shape output)
		(at 67.31 138.43 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0856e175-15b3-4288-974a-9bf48661279e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A3"
		(shape input)
		(at 107.95 68.58 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "08a5ac39-c449-4f46-99f0-9ec1c712addd")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 68.58 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "ODTACK"
		(shape tri_state)
		(at 191.77 120.65 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "08db3db4-8355-4520-95bf-f5cf1e6b0a9d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D14"
		(shape input)
		(at 26.67 116.84 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "095154c0-54a5-4ba7-9f5d-42d481328446")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 116.84 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_CS_N"
		(shape output)
		(at 82.55 76.2 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0a49073b-b418-4f58-b0cc-fd68cb0a8087")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D12"
		(shape bidirectional)
		(at -63.5 39.37 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0a5ecd69-f2a0-47ba-a111-6f411b7869de")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 39.37 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D12"
		(shape input)
		(at 26.67 121.92 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0a8dfe3a-7a26-4026-baad-c807eba85b20")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 121.92 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D8"
		(shape output)
		(at 120.65 138.43 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0b07750a-4d01-4ffb-b3bf-63e896781ddd")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA5"
		(shape bidirectional)
		(at 139.7 81.28 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0ba32f08-6a03-43c7-a288-0a28d4b1439a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 81.28 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A2"
		(shape output)
		(at -50.8 13.97 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "0ee8c6ff-fde5-41c5-854f-dbb978cc3e62")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 13.97 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_RD_NWR"
		(shape output)
		(at 82.55 78.74 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "0f82a668-dae6-4bbf-a202-f5f0d53c8a4c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 78.74 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "ROSCO_5V"
		(shape passive)
		(at -36.83 90.17 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "10022be2-b6ab-441f-8eb3-7e0e9dabec90")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -36.83 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "RESET"
		(shape input)
		(at 166.37 140.97 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "11eef667-ca28-4a1c-af84-f549cfacd97d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 140.97 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA4"
		(shape input)
		(at 26.67 147.32 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "11fddc7c-fec7-46cc-95f1-902b8539ff55")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 147.32 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 194.31 67.31 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "12301764-c5eb-4e3c-b8e8-0a3ee85e0555")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 67.31 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape input)
		(at 198.12 26.67 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "1274c80d-6b16-49ae-9f8c-e4405c76e0e0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 26.67 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 173.99 96.52 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "12974ba6-8bcb-4a6c-99ee-39ac86308aa8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 173.99 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "E"
		(shape input)
		(at -63.5 80.01 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "12ca1b66-7567-41f1-9243-256c90386f6d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -67.6342 80.01 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "68_D13"
		(shape input)
		(at 102.87 125.73 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "1328804f-0482-4279-8f86-e9c83b0b12e5")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A11"
		(shape input)
		(at 210.82 133.35 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "168e0ed8-e24f-4297-8686-cda0ce626cc8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 110.49 91.44 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "16c1773c-1164-49e6-b96d-22335a62abdb")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 110.49 91.44 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R1"
		(shape output)
		(at 161.29 68.58 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "16fdc9bb-775b-45d6-9bbd-6b04ef873c40")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 68.58 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "UD_5V"
		(shape passive)
		(at 243.84 31.75 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "189207b6-f0cd-4b97-99d1-2003537b354c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 243.84 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC2"
		(shape output)
		(at -63.5 87.63 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "19ef5bb0-f729-4dac-b72f-17e6391fde57")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 87.63 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 107.95 109.22 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "1bbbc756-aed9-4cd8-b0bc-e28c8cec3d92")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 109.22 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G0"
		(shape input)
		(at 194.31 77.47 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "1cab499e-2560-4693-9d2c-465dd7eb3740")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 77.47 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D15"
		(shape output)
		(at 120.65 120.65 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "1d32e73d-63da-427c-8d01-3759ecdf50c1")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "OIRQ"
		(shape tri_state)
		(at 191.77 130.81 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "1d3bf400-853d-41f2-8ac1-55f68d8a4797")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA3"
		(shape input)
		(at 146.05 130.81 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "1ecf3277-9e13-4581-90a5-9f2165c745e4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA7"
		(shape input)
		(at 26.67 139.7 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "1f61279e-e5cb-4307-a571-336d24df7f86")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 139.7 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA3"
		(shape bidirectional)
		(at 139.7 76.2 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "2142e0bf-5264-4a39-9869-5e95ac54be2f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A9"
		(shape output)
		(at -50.8 31.75 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "216a099a-533e-48b2-95c6-7525eecf9fa8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A5"
		(shape input)
		(at 236.22 130.81 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "21a2af47-1228-4988-bf57-c6310952d705")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A10"
		(shape input)
		(at 210.82 130.81 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "2213ab31-4442-4148-a392-ed4d0a9346c2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA2"
		(shape bidirectional)
		(at 139.7 73.66 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "241234d4-a5a0-410f-8e37-c3bf532d8d6c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "CLK"
		(shape input)
		(at -63.5 49.53 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "24d5aa7b-8ae4-429f-9890-6c9a1cb40e5a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -70.0533 49.53 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA3"
		(shape input)
		(at 26.67 149.86 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "258f29f3-2392-4cac-931c-040dfff9ca9a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 149.86 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_CS_N"
		(shape input)
		(at 82.55 39.37 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "2763b292-0db7-49d0-902f-228b4db1725d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 39.37 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A5"
		(shape output)
		(at -50.8 21.59 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "298ff42b-7966-487a-9342-b54d8cfa02d4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA4"
		(shape input)
		(at 146.05 128.27 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "2b2acd0a-5629-4d0c-99d1-3cb713c21524")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IRQRS"
		(shape input)
		(at 177.8 109.22 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "2c0545f6-c53a-4f1f-8264-b9935009070f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 177.8 109.22 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A1"
		(shape input)
		(at 166.37 133.35 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "31067f5c-492d-4e86-822a-5fa9ce842d2e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 116.84 48.26 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "32c107bb-a729-461e-ae30-9015974c56ae")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 116.84 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VPA"
		(shape tri_state)
		(at 191.77 123.19 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "330a4f69-21ee-42a0-acc0-e47ba80c342b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 256.54 115.57 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "33e5faec-56e4-4af1-bcec-488ee2e2d77b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 115.57 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{UDS}"
		(shape input)
		(at -63.5 59.69 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3718b1bc-fce0-49dd-9f61-9fade9046b3e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -70.2952 59.69 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 194.31 40.64 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "37575ccb-8dd6-4963-bb35-096b27dc5c7f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 40.64 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DV_DE"
		(shape output)
		(at 161.29 83.82 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3822963f-3e40-4d7b-b3b6-2a140345959b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 83.82 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 220.98 107.95 270)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3882a09a-58d5-4341-9782-405d0047ca5a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 220.98 107.95 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D8"
		(shape input)
		(at 26.67 132.08 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "38966a2a-4cd6-4b6c-8483-390d49b09d5f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 132.08 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "LDS"
		(shape output)
		(at -72.39 149.86 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "38f9615e-98ba-4ad6-bfbe-5637deeacfa0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -72.39 149.86 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{IRQ_6}"
		(shape output)
		(at -50.8 82.55 0)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3b6a5166-b603-4848-b821-fa4c8853505a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -41.3211 82.55 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B1"
		(shape input)
		(at 207.01 50.8 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3b8b6c42-f057-4d75-902b-e9beec01bd46")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 50.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA1"
		(shape bidirectional)
		(at 139.7 71.12 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3ccee429-f64b-4372-9b34-0d4fd7f84f1a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 71.12 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA4"
		(shape bidirectional)
		(at 139.7 78.74 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3d6956a8-08d1-41ed-80c9-6095b5bbd123")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 78.74 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R1"
		(shape input)
		(at 194.31 50.8 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3e5483ae-90d7-436c-9253-a13075627a27")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 50.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G3"
		(shape output)
		(at 161.29 55.88 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3e6a7fd4-cbbd-46b1-b2da-865144f2d677")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 139.7 27.94 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "3f15795e-0a13-4ec0-b289-b88b28859ea7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 27.94 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B2"
		(shape input)
		(at 207.01 48.26 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3f345ce2-05e5-413d-b5c2-2921c04d7118")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 115.57 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "3f73f985-93b9-45f7-815c-47df9e801b1f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 115.57 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "RnW"
		(shape output)
		(at -59.69 185.42 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "42375038-6326-4f92-ae40-b290026b5510")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -59.69 185.42 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "R{slash}~{W}"
		(shape input)
		(at -63.5 54.61 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "432e050f-ecf3-4b4c-a6a7-2d4796be5a29")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -70.5371 54.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA6"
		(shape bidirectional)
		(at 139.7 83.82 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "448643b6-5936-44e6-89e4-b7f7d3804f62")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 83.82 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A7"
		(shape output)
		(at -50.8 26.67 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "44e05216-376b-4727-9c92-7a947309ccc8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 26.67 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A3"
		(shape output)
		(at -50.8 16.51 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "44e47c94-4fe2-4227-b743-e7583c2ef679")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 16.51 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B1"
		(shape output)
		(at 161.29 73.66 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "45d80c01-cfd2-47e3-bd26-72867d638802")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC2"
		(shape input)
		(at 166.37 128.27 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "46aefc9b-c357-4130-96ca-3f38f8fbcb3f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G3"
		(shape input)
		(at 194.31 69.85 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "4926867e-08e2-4a87-84a1-e578c0a5ecf5")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 266.7 73.66 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "4a34ae05-f6a3-4f4d-8a10-1a3e9a792e33")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 266.7 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A16"
		(shape output)
		(at -50.8 49.53 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "4a80dcee-51d8-4694-a643-4c9e09c0c7be")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 49.53 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "RESET"
		(shape output)
		(at -72.39 154.94 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "4bbf8f86-70c6-4981-9d66-b134338438f1")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -72.39 154.94 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B2"
		(shape output)
		(at 161.29 66.04 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "4e534b3a-72b0-43b1-abb1-4b086d7f9632")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 66.04 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VPA"
		(shape output)
		(at -86.36 60.96 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "4e68181c-f4a4-485e-8bb4-3042a5758929")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -86.36 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D10"
		(shape bidirectional)
		(at -63.5 34.29 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "52260bff-d81f-42ae-b544-c7a77bb8491e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D14"
		(shape bidirectional)
		(at -63.5 44.45 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "538a9782-6798-4078-8df3-e68c985cb4cb")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 44.45 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A8"
		(shape output)
		(at -50.8 29.21 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "53e0efbf-6114-4a99-8304-a8eaf4841e76")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 29.21 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B0"
		(shape output)
		(at 161.29 81.28 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "54c0349e-1f7b-4841-a544-15753856d3e9")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 81.28 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R3"
		(shape input)
		(at 194.31 45.72 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "56787317-1778-4c7e-87d2-7f631f5d2f93")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM1"
		(shape output)
		(at 82.55 68.58 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "56e6576d-7eea-4353-b756-ed43f21d96b0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 68.58 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A1"
		(shape output)
		(at -50.8 11.43 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "5780437e-ae3e-44a8-a9ae-f346fcd43937")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 11.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC0"
		(shape output)
		(at -63.5 82.55 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "58738b48-4f69-43fb-81c3-6416c95393ed")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 82.55 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC1"
		(shape output)
		(at -63.5 85.09 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "5a64908e-d83f-4352-b30b-8efc849c83d1")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 85.09 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA6"
		(shape input)
		(at 146.05 123.19 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "5bd88ea8-5b3b-46fe-b5a1-d0988b664436")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DV_CLK"
		(shape output)
		(at 161.29 86.36 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "5be89974-2cfb-4129-abe8-a5dbd49fa875")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 86.36 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "ROSCO_5V"
		(shape passive)
		(at 243.84 43.18 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "5c82fb24-4048-4ef1-8a27-c59af52c1b79")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 243.84 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 194.31 43.18 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "5d6f5ca7-0535-4333-aabd-bbc5175534b1")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A15"
		(shape input)
		(at 236.22 133.35 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "5dfbf533-2db4-42f4-9a5f-f8fe89e23dd3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM3"
		(shape output)
		(at 82.55 73.66 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "60a96ef1-8973-43ef-8942-89be91a12017")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_CS"
		(shape input)
		(at 107.95 76.2 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "61cce527-53fa-4cdc-8a73-42ed7718e7df")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AUDIO_R"
		(shape output)
		(at 139.7 66.04 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "62e02e03-bf35-4663-a8e9-4ded610b4490")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 66.04 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA0"
		(shape bidirectional)
		(at 139.7 68.58 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "632225a1-afbe-4b9e-aa0d-92a96fb027e3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 68.58 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 105.41 165.1 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "63243394-e30d-4b12-a427-e63256e12a12")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 105.41 165.1 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM3"
		(shape input)
		(at 139.7 60.96 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "63f1c3f4-ccee-446b-a8b9-fe6e5d2ae16d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 207.01 43.18 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "63f3cb4d-f6d3-422b-9b62-2d4fb149dec8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R2"
		(shape input)
		(at 194.31 48.26 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "650767ae-6d64-4e18-90e6-3e46a7f3e7fd")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D11"
		(shape input)
		(at 102.87 130.81 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "6531fbdf-870e-4c71-9e38-31ecd7a40a52")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D11"
		(shape output)
		(at 120.65 130.81 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "654cf088-f9a4-4b86-8434-4cace82ed53b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape input)
		(at 104.14 53.34 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "656864f9-e88e-4749-804a-51936f0eb9de")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 104.14 53.34 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_HS"
		(shape output)
		(at 161.29 48.26 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "697cf424-481d-464c-aa31-091c171b839c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "RESET"
		(shape input)
		(at 107.95 81.28 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "69a8dfc9-fbc8-4ed0-97a1-d4c1659d260b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 81.28 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_R"
		(shape output)
		(at 191.77 133.35 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "69be26db-e587-4d2d-806c-eb6576e241f4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_W"
		(shape output)
		(at 191.77 128.27 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "6a32122c-b645-4cab-a33c-ec38a1c4fa9c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "RnW"
		(shape input)
		(at 107.95 78.74 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "6ed8c633-45b1-4c76-8cf1-091e3c27771b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 78.74 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "UD_5V"
		(shape passive)
		(at 139.7 45.72 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "6f74c79f-c10c-4517-b560-a3a3595e6833")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IOSEL"
		(shape output)
		(at -86.36 58.42 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "6fe63d83-e989-418f-b048-4e35ae433ce1")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -86.36 58.42 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A15"
		(shape output)
		(at -50.8 46.99 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "6fe9a294-4aaa-44f1-b1e6-1eaee9307195")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 46.99 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DTACK"
		(shape tri_state)
		(at -59.69 182.88 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "6fefbf71-8e8a-4d51-b54c-86c4a4467c8a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -59.69 182.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "JBODGE_GND"
		(shape passive)
		(at 161.29 43.18 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "706db8d6-5af6-47d2-95fc-b4931ffb5174")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A13"
		(shape output)
		(at -50.8 41.91 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "71359711-1eea-4587-8ce7-b71ee940c8b2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 41.91 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 175.26 90.17 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "73b25209-3202-4ff2-ba41-d313ef5e2335")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 175.26 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{BG}"
		(shape input)
		(at -63.5 64.77 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "74db60c4-c641-40ea-a22c-365bd85cb29d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -69.0252 64.77 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "RnW"
		(shape input)
		(at 166.37 143.51 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "751bd19d-b393-4ccd-bb4c-de190210a755")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 143.51 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A11"
		(shape output)
		(at -50.8 36.83 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "755a301d-329a-4bbb-80a9-07cf3a6069f5")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 36.83 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 256.54 101.6 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "756298fd-0937-47fe-bdf8-f3a450a298cd")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 101.6 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA5"
		(shape output)
		(at 67.31 125.73 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "758d2aa6-7474-41b0-8d3f-bed52f9697e7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R3"
		(shape output)
		(at 161.29 53.34 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "764a18df-e9a7-43f9-bfc1-03c6a63957fb")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 53.34 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AUDIO_L"
		(shape input)
		(at 198.12 21.59 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "7671a359-dbb5-4ac9-8b12-51fcdc1a2999")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A8"
		(shape input)
		(at 210.82 125.73 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "76df2ea1-d853-4715-9d45-af2343d8bc83")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 109.22 97.79 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "77c01c3f-2797-4cd2-9867-3289d06a0f8f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 109.22 97.79 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 113.03 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "77ea0fd1-e7ad-472b-bd8b-06a214b8fda6")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 113.03 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{DMAC_REQ1}"
		(shape output)
		(at -50.8 72.39 0)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "785e079b-0ce1-4d38-af88-7f75d5f7a740")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -36.8082 72.39 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM0"
		(shape output)
		(at 82.55 66.04 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "789af209-faf9-49f3-9c75-00c36f8caeb6")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 66.04 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{BR}"
		(shape output)
		(at -63.5 67.31 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "794dca38-1673-4227-82f7-70d7fc6e356a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -69.0252 67.31 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "68_D11"
		(shape input)
		(at 26.67 124.46 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "79f8c6f7-e5ba-4926-a74f-11510159896d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 124.46 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA5"
		(shape input)
		(at 26.67 144.78 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "7a84a919-d6e7-474b-8fec-e76f3a69405c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 144.78 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_RESET_N"
		(shape passive)
		(at 139.7 33.02 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "7ab60799-9263-4b8e-bf81-dc69a3d03a38")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 33.02 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM0"
		(shape input)
		(at 139.7 53.34 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "7b1bfe76-0a17-47f3-a161-7b8d61a89b87")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 53.34 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "OIRQ"
		(shape input)
		(at 173.99 99.06 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "7d4815e3-c638-4a84-889f-2c830721ab99")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 173.99 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A13"
		(shape input)
		(at 210.82 138.43 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "7e5f2a77-7491-4515-bab3-a4a8a528095b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D9"
		(shape input)
		(at 26.67 129.54 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "7ed6e266-bba6-44d6-811f-45e1389af081")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 129.54 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D14"
		(shape input)
		(at 102.87 123.19 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "7fffdaa8-870a-4f52-b567-6e9aab4dfaf8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA1"
		(shape input)
		(at 146.05 135.89 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "803189d7-24b9-4421-a352-d37805548554")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM2"
		(shape input)
		(at 82.55 34.29 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "80b992dd-adad-46de-b071-3b03d874a4da")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_RESET_N"
		(shape output)
		(at 270.51 60.96 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "80c647f7-f2e0-4a45-833f-3333da0462ba")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 270.51 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "ODTACK"
		(shape bidirectional)
		(at 243.84 21.59 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "81aa678b-334a-43ac-a257-0f46ef83994a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 243.84 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 220.98 87.63 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "84aba43e-e981-4425-8cf6-c1f9ab72d9dc")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 220.98 87.63 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 256.54 118.11 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "85641189-7565-43b5-9cf2-4dceae5cadfe")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 118.11 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_W"
		(shape input)
		(at 67.31 146.05 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "8775e214-b91e-41cd-8eaa-4940bc83076d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 146.05 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "JBUS_RESET_N"
		(shape input)
		(at 247.65 60.96 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "88a3e5eb-ae55-497e-a0cf-818fdb16ba5d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 247.65 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DTACK"
		(shape tri_state)
		(at 274.32 21.59 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "8a02a93d-b340-4524-9ccc-7b7168919cfa")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 274.32 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D15"
		(shape bidirectional)
		(at -63.5 46.99 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "8b5cfb37-c6a2-4b89-b72a-e4aa0254505e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 46.99 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R2"
		(shape output)
		(at 161.29 60.96 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "8c34a10c-7c89-4d11-a53f-f54350bce04b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA6"
		(shape input)
		(at 26.67 142.24 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "8d079e83-9d07-4a86-a69c-3d58002aa05d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 142.24 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 139.7 50.8 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "8d1f7582-6207-4011-9899-6b5d4ac58938")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 50.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 274.32 52.07 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "8d5aaeb5-500e-414c-85fc-3e2a91a36362")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 274.32 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape input)
		(at 198.12 24.13 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "8e2c6070-9bbe-49be-9b1e-932770358f25")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA1"
		(shape output)
		(at 67.31 135.89 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "8ecdee9f-397d-4cd9-a2fe-01055e357597")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D14"
		(shape output)
		(at 120.65 123.19 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "8f5458b0-13c2-4dd2-bb32-93cf1c78faab")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 207.01 40.64 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "90c24c42-5958-4254-adb3-aca256711644")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 40.64 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B3"
		(shape input)
		(at 207.01 45.72 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "90c9b0ee-e8ab-4ba3-aef1-4d3ace67a7e7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D13"
		(shape output)
		(at 120.65 125.73 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "90f954b1-c6a5-4e9b-acf9-3ad300421032")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IPL1"
		(shape tri_state)
		(at 204.47 91.44 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9350b8ed-faeb-4594-a1be-aa442d9ebdde")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 204.47 91.44 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 194.31 64.77 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "939d48e1-359b-4021-900b-96b35ccffcc4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 64.77 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA1"
		(shape input)
		(at 26.67 154.94 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "93db384e-741c-4d8f-b6cd-ec07fb55007d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 154.94 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_RD_NWR"
		(shape passive)
		(at 139.7 40.64 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "946074de-9f6e-4e1f-aeb9-8aa81c67f40e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 40.64 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D9"
		(shape input)
		(at 102.87 135.89 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "95d1bb32-deb7-40df-b8a9-0e9348b04c8d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AUDIO_R"
		(shape input)
		(at 198.12 29.21 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "95ec09db-ce4d-40d9-a918-581235198a5c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 29.21 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D12"
		(shape output)
		(at 120.65 128.27 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "97c8da85-307c-4e85-9961-5e89e1b3221e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA3"
		(shape output)
		(at 67.31 130.81 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9808e428-a334-4822-8dad-a31489593738")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM0"
		(shape input)
		(at 82.55 29.21 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "98a1a3f6-548a-42d3-98ec-3adbaa05206b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 29.21 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "UD_IRQ"
		(shape output)
		(at 161.29 40.64 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "98b36750-0972-4c13-b122-5eb6f10a6ef0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 40.64 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A12"
		(shape output)
		(at -50.8 39.37 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "99874da0-b997-4239-b500-eb003a249d17")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 39.37 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM2"
		(shape output)
		(at 82.55 71.12 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9abc2b78-c63e-4bbf-91e9-18e8f9834c1f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 71.12 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "SEL_1"
		(shape output)
		(at 236.22 120.65 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9c2bd7b2-f858-474e-8c0e-2b8440c21989")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 104.14 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9ca1c323-aed0-4a1b-a9c8-8a9a4704aecc")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 104.14 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_BYTESEL"
		(shape output)
		(at 82.55 63.5 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9ccbb358-ed68-4484-b4f9-58095eadbedf")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 63.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B0"
		(shape input)
		(at 207.01 53.34 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9d00bb5f-73cc-4cc2-93d0-e3a583731ccf")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 53.34 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA2"
		(shape input)
		(at 26.67 152.4 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9e0a9fa7-01ae-411c-bcce-5ee2fcbf5657")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 152.4 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape input)
		(at 125.73 110.49 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9e7b8bba-a88b-4d94-afde-3fcab09ee338")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 125.73 110.49 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R0"
		(shape input)
		(at 194.31 53.34 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9e7f5345-fca1-4506-922b-5ba085f442a4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 53.34 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{DMAC_ACK1}"
		(shape input)
		(at -50.8 74.93 0)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9e80099b-7052-4d55-aedf-ddf9e8e0424e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -36.9291 74.93 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA0"
		(shape input)
		(at 146.05 138.43 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9ef9de94-5425-4d1b-986d-ca66f586a09c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "LDS"
		(shape input)
		(at 236.22 125.73 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9f05ed13-c1f1-4539-8117-59ce67da106a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "UDS"
		(shape output)
		(at -72.39 152.4 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9f4602fd-b3fb-44a2-b0dc-771e3c0fe07f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -72.39 152.4 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{HALT}"
		(shape bidirectional)
		(at -63.5 74.93 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "9fa9d93f-874d-4ea3-8725-6f50eca0d703")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -72.0113 74.93 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "68_D10"
		(shape input)
		(at 102.87 133.35 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "9fd1bacd-ccdc-4300-88da-53b12205996d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "JBUS_RESET_N"
		(shape output)
		(at 82.55 81.28 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a0370721-aab0-407c-ae7f-f95613c2b11e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 81.28 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_VS"
		(shape output)
		(at 161.29 50.8 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "a04365c3-ee4c-47f0-a4fd-e33e4096f60a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 50.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 20.32 163.83 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "a0f02879-b094-4ecf-9823-fb8233505ef0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 20.32 163.83 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G2"
		(shape input)
		(at 194.31 72.39 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a21bca77-92f3-49a7-924f-ce710384465d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 72.39 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "JBODGE_GND"
		(shape passive)
		(at 243.84 52.07 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a2fee028-3318-4a9c-8ede-d5fcc9495e73")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 243.84 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D10"
		(shape input)
		(at 26.67 127 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "a35fd9ec-1432-402e-8e81-255a5a355491")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 127 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D9"
		(shape output)
		(at 120.65 135.89 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a37563b3-6bfe-417a-b73c-06df0a51e14e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D13"
		(shape bidirectional)
		(at -63.5 41.91 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a5022a4e-c9d7-4468-9080-61db7c5e0bb7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 41.91 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{VMA}"
		(shape input)
		(at -50.8 69.85 0)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "a70713f0-1311-4e98-a747-da6283382bf4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -44.1862 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 207.01 67.31 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "a817ed1f-a181-41e5-88f9-6cd04444e6a8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 67.31 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 204.47 101.6 270)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a8802d7e-1bf8-4cdb-8a4d-c0b847a33e35")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 204.47 101.6 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM1"
		(shape input)
		(at 139.7 55.88 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "a9f43c74-2fe1-4d34-8b80-1a1fc2272fbe")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A6"
		(shape input)
		(at 210.82 120.65 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "aa10be28-cbbc-425c-ad05-091c22e5e06e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G1"
		(shape output)
		(at 161.29 71.12 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "aa3637fc-8f6c-46d3-8877-bb30ff3b22f2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 71.12 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA5"
		(shape input)
		(at 146.05 125.73 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "aafae7ab-727b-4168-9126-a7671d1c34b3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 96.52 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "ab4501ad-b496-4521-a15e-8babc9de31e2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{DTACK}"
		(shape input)
		(at -63.5 72.39 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b09943e9-da02-415d-a4a8-e2c4021e52d0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -72.3514 72.39 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "68_D15"
		(shape input)
		(at 26.67 114.3 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "b0fb4b79-ecac-4240-88d8-1462e8bc553f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 114.3 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM1"
		(shape input)
		(at 82.55 31.75 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "b163a7a1-c8d0-4e77-8e28-0f9529e996eb")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA7"
		(shape bidirectional)
		(at 139.7 86.36 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b1a9dcdc-571a-45f4-a2b5-169c767dec6d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 86.36 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A2"
		(shape input)
		(at 166.37 135.89 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b383e3dd-af50-4154-9dff-f22bb19a8348")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A17"
		(shape input)
		(at 210.82 143.51 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b3a4a91e-9649-4740-8f56-1edc9d516c5e")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 143.51 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D8"
		(shape input)
		(at 102.87 138.43 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "b5e6c56f-3757-472f-9a7d-cc5c8bd5c20a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AUDIO_L"
		(shape output)
		(at 139.7 63.5 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b709c135-46c7-41fa-aae7-71710b642546")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 63.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A3"
		(shape input)
		(at 166.37 138.43 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "b756ef10-605a-4fe7-a11f-e0dd08831878")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_RD_NWR"
		(shape input)
		(at 82.55 41.91 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "b950c91c-f49e-4038-8f32-60f8a87f6749")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 41.91 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_R"
		(shape input)
		(at 120.65 146.05 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "bb8f421f-d5df-4988-b506-75c05283886f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 146.05 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 256.54 96.52 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "bcc2a322-156e-4b96-ac20-0b7192f71ff2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A7"
		(shape input)
		(at 107.95 73.66 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "bdcb0706-433d-461d-9a4c-707c5c7b832f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G2"
		(shape output)
		(at 161.29 63.5 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "c30939c5-cc32-4981-a1af-eae418639238")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 63.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A4"
		(shape input)
		(at 107.95 71.12 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "c4ce6626-dfd7-4d29-9b7b-b33d05be2555")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 71.12 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA6"
		(shape output)
		(at 67.31 123.19 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "c69d39a0-b502-4913-9b36-6a69724ef1e4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 99.06 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "c80098b4-eda6-4dbe-81a8-56e72dd1f0f9")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A1"
		(shape input)
		(at 107.95 63.5 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "c87ac6c2-2a6b-4b1c-8ea2-774cc8c20c2b")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 63.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 198.12 19.05 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "c96de12d-a6ff-48bb-8e80-3db79d83547a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 19.05 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A9"
		(shape input)
		(at 210.82 128.27 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ca2ae994-edd3-4e9d-9e64-8cda856e5b4f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA7"
		(shape input)
		(at 146.05 120.65 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "ca6c980a-f9b9-4c84-9aee-6b0fa683d5b2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA2"
		(shape input)
		(at 146.05 133.35 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "cd602aad-630c-4c34-8486-30850c767814")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 146.05 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_R0"
		(shape output)
		(at 161.29 76.2 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "ce7d7cee-be9c-49da-b8b0-7a1210edb5f6")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A17"
		(shape output)
		(at -50.8 52.07 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "cf8354ef-5b25-46d3-838a-4e59b55d6c10")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 256.54 99.06 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "d02e4402-aaa3-4aef-ad01-32440aec9af3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_G1"
		(shape input)
		(at 194.31 74.93 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "d10d42aa-53db-4af2-b800-09ae322699ce")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 194.31 74.93 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A6"
		(shape output)
		(at -50.8 24.13 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d1a90721-9d19-45e3-8d8a-15648fb1ee19")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IOSEL"
		(shape input)
		(at 236.22 123.19 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d23e49fc-5c2b-40a2-b38e-88af60f50a44")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "VGA_HS"
		(shape input)
		(at 207.01 77.47 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d4089dc8-6666-4ceb-8ac8-be92c9072264")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 77.47 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D8"
		(shape bidirectional)
		(at -63.5 29.21 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "d56a9ad7-60b4-476e-a178-713ad4708847")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 29.21 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A10"
		(shape output)
		(at -50.8 34.29 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d5d2b4de-0625-4062-8862-fb3a23c5aca4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A16"
		(shape input)
		(at 236.22 135.89 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d624d0e0-f348-4df5-aaf7-a408e0ec196c")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{LDS}"
		(shape input)
		(at -63.5 62.23 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "d6990980-c028-4db2-a7e2-ce40e1d26066")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -69.9928 62.23 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "FPGA_CS"
		(shape output)
		(at 191.77 138.43 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d6f324b4-f1a4-4e8d-8680-3a603971a5d2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IRQRS"
		(shape output)
		(at 191.77 140.97 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d83369c8-0b59-4edf-8eb6-f90b61a6deea")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 191.77 140.97 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA0"
		(shape input)
		(at 26.67 157.48 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "d91497b5-cde3-4ae5-86aa-3d4d49985438")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 26.67 157.48 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA2"
		(shape output)
		(at 67.31 133.35 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "d9787588-f3fb-41bf-9464-45709f6c9bfd")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "JBUS_RESET_N"
		(shape input)
		(at 82.55 44.45 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "dc21cd25-24ce-487d-ae0f-c787d0451022")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 44.45 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D12"
		(shape input)
		(at 102.87 128.27 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "dda830c4-bcd4-4489-90ad-74ff280a948d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 102.87 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "UD_IRQ"
		(shape input)
		(at 166.37 146.05 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ded2cf1a-d159-462d-bbd0-86960f01a643")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 146.05 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DMAC_PCL1"
		(shape bidirectional)
		(at -50.8 77.47 0)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e0de5d7b-89d8-4af8-bfe3-46b2fbbda934")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -36.9896 77.47 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 118.11 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e2873f87-375b-4731-977e-0b9031dc438f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 118.11 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D11"
		(shape bidirectional)
		(at -63.5 36.83 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "e2e33c4c-d229-4dcc-94f4-cbad56d82d73")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 36.83 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A4"
		(shape output)
		(at -50.8 19.05 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e443acb3-8b6c-4c30-ada8-1138cf8ebbbb")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 19.05 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC1"
		(shape input)
		(at 166.37 125.73 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "e5ee5483-b69d-4c2d-9e9b-f2e82fb35ce8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape input)
		(at 88.9 110.49 90)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e647540d-3ddf-41cf-b080-8f87808f10f8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 88.9 110.49 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A14"
		(shape output)
		(at -50.8 44.45 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e76ada43-9ac1-43e7-a68a-be2f290f7fa7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -50.8 44.45 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 198.12 31.75 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e797507a-6061-4c00-905f-b7e303715cb5")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 198.12 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_BYTESEL"
		(shape input)
		(at 82.55 26.67 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e79fd78f-7b9d-4168-b7eb-9443912be119")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 26.67 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D10"
		(shape output)
		(at 120.65 133.35 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "e881d260-5109-40db-85dc-0f204df602a2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 120.65 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A12"
		(shape input)
		(at 210.82 135.89 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "e8eee143-1470-4476-a38f-90380c8ca0c7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DV_DE"
		(shape input)
		(at 207.01 72.39 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "e8f12952-21d8-4006-8369-e091f4caf0f7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 72.39 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_BYTESEL"
		(shape input)
		(at 139.7 43.18 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ea36bec6-342f-4873-9838-cce1a96bff47")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A7"
		(shape input)
		(at 210.82 123.19 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "eb52b76a-3f4e-412e-835c-0fcd629b7c34")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_DATA7"
		(shape output)
		(at 67.31 120.65 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "eb657fd2-998a-466d-9e30-b2c3a34ed02f")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 67.31 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at -80.01 90.17 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ec123157-4de1-49df-8ee1-f8642a22a7d2")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -80.01 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "SEL_1"
		(shape input)
		(at 166.37 120.65 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ec94ac03-5957-4fb0-bb33-71a54db3c76a")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_CS_N"
		(shape passive)
		(at 139.7 38.1 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ecc0e320-dbe8-4dae-a9a3-79d760b3999d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 38.1 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "IPL1"
		(shape tri_state)
		(at -33.02 80.01 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "ecf34210-5fa7-4596-9639-67e7ee18ecd7")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -33.02 80.01 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
	)
	(global_label "VGA_B3"
		(shape output)
		(at 161.29 58.42 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "ed854ffa-aa5e-48c3-91d6-1de205981800")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 161.29 58.42 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{AS}"
		(shape input)
		(at -63.5 57.15 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ef24f5cc-3c26-4c65-b503-5da6dd486895")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -68.7833 57.15 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "UDS"
		(shape input)
		(at 236.22 128.27 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "efc4a4b9-d8ea-4479-8c1d-d7cd6894bcad")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 236.22 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "AS"
		(shape input)
		(at 166.37 130.81 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f0a538e8-10e4-46c3-9dee-0f90cb5b00bc")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "GND"
		(shape passive)
		(at 269.24 120.65 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "f15b91d4-bad7-4e0c-8dfa-a423e2a6fad0")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 269.24 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PMGND"
		(shape passive)
		(at 247.65 73.66 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f2a4d013-ad4e-4092-a029-ed5b7d3997c3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 247.65 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "A2"
		(shape input)
		(at 107.95 66.04 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "f3ae6196-8093-4b79-9a8c-0f690988b3db")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 107.95 66.04 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{BERR}"
		(shape output)
		(at -63.5 69.85 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f44b03c4-b569-48b4-ae36-b875c8a4b1c4")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -71.4442 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM3"
		(shape input)
		(at 82.55 36.83 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "f44bb48a-3a07-4cee-bb3c-007dc627cdf9")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 82.55 36.83 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 207.01 64.77 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "f47fcf1c-b7d4-42bb-b87f-9cbca8330729")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 64.77 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "DV_CLK"
		(shape input)
		(at 207.01 69.85 0)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify left)
		)
		(uuid "f58ddcb3-45f8-418d-94af-fe00516ea4d8")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 207.01 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "PCLK"
		(shape input)
		(at -63.5 52.07 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f7855f9d-c65d-462a-b940-c0028380da0d")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -71.3233 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "A14"
		(shape input)
		(at 210.82 140.97 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f9c72920-45da-4a39-9066-645646d4fd44")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 210.82 140.97 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "FC0"
		(shape input)
		(at 166.37 123.19 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f9d4f0f0-c25d-4639-a40f-bbae3e87e156")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 166.37 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "BUS_REG_NUM2"
		(shape input)
		(at 139.7 58.42 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "f9ee8c0e-3421-4e2b-aea6-a53f2a81e710")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 139.7 58.42 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "68_D9"
		(shape bidirectional)
		(at -63.5 31.75 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "fa3f256c-643d-47ee-914b-1f181e3b36e3")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -63.5 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "~{RESET}"
		(shape bidirectional)
		(at -63.5 77.47 180)
		(fields_autoplaced yes)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "fb639677-640c-4b07-9571-8fc9886afded")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at -73.3416 77.47 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify right)
				(hide yes)
			)
		)
	)
	(global_label "3V3"
		(shape passive)
		(at 256.54 104.14 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "fe65e62a-058b-4159-a7a9-88e90d0ec370")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 104.14 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 256.54 120.65 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "fe9a967f-37e5-4673-8c49-175bbb87d669")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(global_label "5V"
		(shape passive)
		(at 256.54 113.03 180)
		(effects
			(font
				(size 1.27 1.27)
			)
			(justify right)
		)
		(uuid "ffacb8cc-4cc5-43dd-9881-8db14759d194")
		(property "Intersheetrefs" "${INTERSHEET_REFS}"
			(at 256.54 113.03 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x32_Odd_Even")
		(at 41.91 60.96 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005eb06e33")
		(property "Reference" "J1"
			(at 43.18 19.685 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_02x32_Odd_Even"
			(at 43.18 19.6596 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:pin-2X32"
			(at 41.91 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 41.91 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 41.91 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "dee3b128-08c9-43f8-bd5c-d34663d6f2a2")
		)
		(pin "3"
			(uuid "aa2a6c31-2684-4016-8988-eeb0490c94cc")
		)
		(pin "5"
			(uuid "d1c0404e-1562-40c2-b0bf-a8efab159f13")
		)
		(pin "7"
			(uuid "472190f2-511d-4664-a241-54251edbf5ca")
		)
		(pin "9"
			(uuid "f7dee018-c93e-431d-b9e4-c95d197abe79")
		)
		(pin "11"
			(uuid "1d8893a6-bd06-40c6-8e16-b5e47a45a6db")
		)
		(pin "13"
			(uuid "f7eebc4c-52ae-4b43-9011-8faefba3aa37")
		)
		(pin "15"
			(uuid "168b5845-7e1c-4436-8d58-0c1c42056822")
		)
		(pin "17"
			(uuid "53a295e2-57fa-4bd4-9c1c-b40dcb704aec")
		)
		(pin "19"
			(uuid "598d7732-b9d0-4269-b8b0-aeecb182c202")
		)
		(pin "21"
			(uuid "13d98aae-7522-48f9-ac86-48a4f2ac8d32")
		)
		(pin "23"
			(uuid "d0bb237e-9d58-464c-b1da-9cd77a6e3ab3")
		)
		(pin "25"
			(uuid "bdfc9669-19e3-457f-985b-bea4deb8a590")
		)
		(pin "27"
			(uuid "1b061585-0915-443b-9143-1960415d31a4")
		)
		(pin "29"
			(uuid "8a5706a7-c728-457d-a471-a771f037f03d")
		)
		(pin "31"
			(uuid "bf46e2be-64f4-4087-bc17-8758141130f7")
		)
		(pin "33"
			(uuid "e4a30d1a-720d-490b-8056-181af45e828c")
		)
		(pin "35"
			(uuid "79f99880-6164-4290-a3c3-ed171304b312")
		)
		(pin "37"
			(uuid "5325e907-a751-4faf-ad80-ac4cbc22aa71")
		)
		(pin "39"
			(uuid "5289244d-bdf4-477c-a522-fb968e82245f")
		)
		(pin "41"
			(uuid "713fd17e-eaf3-432b-b08f-ace106aa6308")
		)
		(pin "43"
			(uuid "11348efe-a0c1-4480-8bab-db747e820442")
		)
		(pin "45"
			(uuid "07e7f97b-b13c-4dac-b134-1a8b2e6be4aa")
		)
		(pin "47"
			(uuid "1b396148-1e93-4a4a-8764-9017af78cb78")
		)
		(pin "49"
			(uuid "0bfa9fbe-cf96-4c19-8e86-c9e0c307ca14")
		)
		(pin "51"
			(uuid "8e89b65f-d6bf-47e5-b2aa-afd8d71163d5")
		)
		(pin "53"
			(uuid "88899bd5-fc53-4709-8546-1f6402d4aef9")
		)
		(pin "55"
			(uuid "f2e0c98b-6b58-4b02-9c4c-30c48a927f40")
		)
		(pin "57"
			(uuid "6d3ccbb3-fa41-40a8-9db1-295d4132a447")
		)
		(pin "59"
			(uuid "e54de10b-76c3-43f7-97f2-cd63816fa913")
		)
		(pin "61"
			(uuid "161e715c-bdfa-4c98-b033-a743c991ace7")
		)
		(pin "63"
			(uuid "2da9250d-37f8-4df2-8777-14d40a4b2e49")
		)
		(pin "2"
			(uuid "f3d82004-0586-4e00-9c06-587ca02e6f04")
		)
		(pin "4"
			(uuid "c4e66a70-21e4-4ced-95dd-5f78e712af31")
		)
		(pin "6"
			(uuid "4ec4f2e6-46aa-43a4-a698-1f9991f27e6c")
		)
		(pin "8"
			(uuid "7549f679-6432-4b3f-bd7a-890583feefdb")
		)
		(pin "10"
			(uuid "ac8dd163-a635-460a-9f1b-02310d275957")
		)
		(pin "12"
			(uuid "3c1e82ef-7532-4d94-8712-8a3a8091a61c")
		)
		(pin "14"
			(uuid "cd36db83-44ae-41d9-8797-fda03989a87f")
		)
		(pin "16"
			(uuid "7a708897-aa01-4e2b-a748-85cc6f00a0fb")
		)
		(pin "18"
			(uuid "484e7694-b363-469f-8c1a-0074e25c36ea")
		)
		(pin "20"
			(uuid "424a69f9-f74b-449d-9a69-89f4f1092b67")
		)
		(pin "22"
			(uuid "854e4d57-7b39-4972-9d04-4c06ee35e9ee")
		)
		(pin "24"
			(uuid "01446813-faba-40d2-aab8-903cdf6c4628")
		)
		(pin "26"
			(uuid "b84382d9-e6cb-49c2-b170-8cadd86d078a")
		)
		(pin "28"
			(uuid "b2649fa6-aa20-4e32-a7dd-29defa8d6b11")
		)
		(pin "30"
			(uuid "ea3b8f80-806b-46c6-aa15-4e6eb8b2d9b3")
		)
		(pin "32"
			(uuid "b03da890-9e73-4947-ac37-6fb9e3b8f922")
		)
		(pin "34"
			(uuid "6913ede9-fbd8-426b-a783-1c0b63b3e044")
		)
		(pin "36"
			(uuid "cf5f65be-9073-4872-8969-2d71952b0b52")
		)
		(pin "38"
			(uuid "b2b61de0-9d76-4d62-bad6-0849c30c8556")
		)
		(pin "40"
			(uuid "b86e4e5b-246c-4f2a-a887-995f91614f86")
		)
		(pin "42"
			(uuid "87ace33b-232a-4817-8c0e-be008df58695")
		)
		(pin "44"
			(uuid "458e532e-a9a7-4585-88f1-1aea621fd89b")
		)
		(pin "46"
			(uuid "afdb4e8d-59b7-488d-adac-1e3ccdd7d6fc")
		)
		(pin "48"
			(uuid "c31f6718-8ac7-4231-973a-2c20e1910d10")
		)
		(pin "50"
			(uuid "99e9f8d6-7266-4325-9af7-7175d50aaa27")
		)
		(pin "52"
			(uuid "5c0b4ee6-1a97-47ca-acf7-160ab9fba38f")
		)
		(pin "54"
			(uuid "bd64bc76-a5b7-4286-b076-e008a4f10b09")
		)
		(pin "56"
			(uuid "552c1840-dd40-4ca2-bd0d-c16905f10317")
		)
		(pin "58"
			(uuid "421210cf-8548-45f7-8cb6-a9415493dc0e")
		)
		(pin "60"
			(uuid "9254e4e5-9b89-493f-9d72-0d9f3cf3734a")
		)
		(pin "62"
			(uuid "268b338e-d64a-4a0d-8403-8ca50e8b3032")
		)
		(pin "64"
			(uuid "68890ba2-dda2-4534-8f09-274db318aca1")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:PWR_FLAG")
		(at 271.78 31.75 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005eb06e82")
		(property "Reference" "#VCC01"
			(at 271.78 29.845 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "PWR_FLAG"
			(at 271.78 27.3558 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" ""
			(at 271.78 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 271.78 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 271.78 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "9b32c81b-7a52-464a-804e-ba3c8d20fa55")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#VCC01")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 20.32 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd6a2d")
		(property "Reference" "C1"
			(at 23.241 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 23.241 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 21.2852 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 20.32 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 20.32 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "8464acd2-2732-4a7f-a0ef-9209cd19298f")
		)
		(pin "2"
			(uuid "21a6b12b-57e3-4dfb-bd26-b6aa70b3a5bd")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 29.21 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd70d8")
		(property "Reference" "C2"
			(at 32.131 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 32.131 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 30.1752 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 29.21 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 29.21 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "19a8cf3d-8ac4-4e3b-83e7-8321ca367b49")
		)
		(pin "2"
			(uuid "01574643-e054-4b28-9f9b-e239455dc7a9")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 38.1 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd76dd")
		(property "Reference" "C3"
			(at 41.021 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 41.021 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 39.0652 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 38.1 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 38.1 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "2622bbbf-100a-4c58-9fff-a1904f4a89be")
		)
		(pin "2"
			(uuid "fcc5740f-5d45-4895-bfb4-6e1f759b9e9f")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 46.99 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd7bdb")
		(property "Reference" "C4"
			(at 49.911 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 49.911 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 47.9552 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 46.99 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 46.99 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "7c4ff551-e4ec-425f-aee6-3063a99466c8")
		)
		(pin "2"
			(uuid "07088fe7-45ca-49d2-a09e-4b0fc9c0daa7")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C4")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 55.88 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd8054")
		(property "Reference" "C5"
			(at 58.801 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 58.801 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 56.8452 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 55.88 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 55.88 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "4d23dcfe-7334-4045-9d53-3f7677110719")
		)
		(pin "2"
			(uuid "47474d97-e412-440f-a91c-c04d70b4b161")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C5")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 105.41 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005ebd8730")
		(property "Reference" "C9"
			(at 108.331 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 108.331 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 106.3752 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 105.41 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 105.41 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "d40f2228-b1bb-44af-9e5a-cdd3bd0692cb")
		)
		(pin "2"
			(uuid "ea1e968e-35a7-489a-a436-ddedea393d33")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C9")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:CP")
		(at 76.2 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005eca8151")
		(property "Reference" "C7"
			(at 79.1972 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100uF"
			(at 79.1972 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm"
			(at 77.1652 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 76.2 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 76.2 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "032353cd-fd2c-43a8-b954-3ebf5b63749b")
		)
		(pin "2"
			(uuid "b36eabc6-41f9-4d7c-a3d2-05190e7a0e5a")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C7")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:CP")
		(at 87.63 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005eca8c23")
		(property "Reference" "C8"
			(at 90.6272 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "220uF"
			(at 90.6272 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm"
			(at 88.5952 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 87.63 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 87.63 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "fbee074e-79d4-4ed7-8287-272ba4320be0")
		)
		(pin "2"
			(uuid "26c6cbf1-f42a-4e8a-a468-c61573602eba")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C8")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 21.59 0)
		(mirror y)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f36ac4f")
		(property "Reference" "JP1"
			(at 259.08 14.8844 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 17.1958 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
			(at 259.08 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "0516ad00-f74c-4da2-b843-f82c9456f073")
		)
		(pin "2"
			(uuid "b1a76263-89ad-4abd-b80e-6fdeeaf9c1ef")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS245")
		(at 80.01 133.35 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f9320ff")
		(property "Reference" "IC1"
			(at 80.01 108.4326 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "74HCT245"
			(at 80.01 110.744 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-20_W7.62mm_Socket_LongPads"
			(at 80.01 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "http://www.ti.com/lit/gpn/sn74LS245"
			(at 80.01 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 80.01 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "2635bd89-9f63-4772-8c91-f778a10dd4c3")
		)
		(pin "3"
			(uuid "90174200-75ec-4ed9-bf76-8b995036add3")
		)
		(pin "4"
			(uuid "b7f27a75-b270-45a0-85f9-9b313cb14659")
		)
		(pin "5"
			(uuid "e4acbe15-b9c4-4a2d-a494-8ce1a0d28edb")
		)
		(pin "6"
			(uuid "d5fe70ef-581f-43b0-b200-d0cd89ce8327")
		)
		(pin "7"
			(uuid "6667112e-d21f-48d1-b453-f9fed82f3b72")
		)
		(pin "8"
			(uuid "38818d2b-b644-423f-a980-93d633084f8a")
		)
		(pin "9"
			(uuid "ddcc6508-334a-4e53-bb13-ce8774767495")
		)
		(pin "1"
			(uuid "d3f8c838-aeb1-487c-be84-2437bc933c1f")
		)
		(pin "19"
			(uuid "0cefe69f-4a43-4593-80b2-526851b9f9a1")
		)
		(pin "20"
			(uuid "7b7631be-e005-4e03-b86b-17aca7f05135")
		)
		(pin "10"
			(uuid "04ecc5e1-14dd-4261-8cb4-e50161f2872f")
		)
		(pin "18"
			(uuid "5666fea6-347a-4edb-b4cc-0d694730c201")
		)
		(pin "17"
			(uuid "7f268d40-7318-481c-ab29-0e6df2e36ab9")
		)
		(pin "16"
			(uuid "97fda822-3b99-4d0c-8316-8e81def84f69")
		)
		(pin "15"
			(uuid "f7c3f9a2-b479-4817-a6fa-6095f8d67832")
		)
		(pin "14"
			(uuid "69aeff97-b4d2-4fa6-9d4a-47e0f4583d46")
		)
		(pin "13"
			(uuid "20371e76-c4fc-45ba-89e5-dc63159f1768")
		)
		(pin "12"
			(uuid "68c399bc-d4a2-47e1-a187-02c9dc3773bc")
		)
		(pin "11"
			(uuid "4e6ec5bb-b135-451b-be76-5a8a86f24aff")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS245")
		(at 133.35 133.35 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f933841")
		(property "Reference" "IC2"
			(at 133.35 108.4326 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "74HCT245"
			(at 133.35 110.744 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-20_W7.62mm_Socket_LongPads"
			(at 133.35 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "http://www.ti.com/lit/gpn/sn74LS245"
			(at 133.35 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 133.35 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "a94d6cbf-7289-4efd-a137-68673e6ad2c5")
		)
		(pin "3"
			(uuid "960e3a5e-274e-4e80-98cc-39e39a005872")
		)
		(pin "4"
			(uuid "75fea289-62ad-4797-9fdc-610f264cb753")
		)
		(pin "5"
			(uuid "f10cea68-28ad-409d-bcb2-548bb25e8e90")
		)
		(pin "6"
			(uuid "d75cb230-e376-4c62-bb09-74e23bd0e27c")
		)
		(pin "7"
			(uuid "8c3cc497-bf03-413d-aedf-a0100f34bdff")
		)
		(pin "8"
			(uuid "d90dc556-dfc6-440d-9425-2b5007cc96cf")
		)
		(pin "9"
			(uuid "d7562903-769a-4b32-ab18-f2a3d8767142")
		)
		(pin "1"
			(uuid "18edf7e5-f42a-4384-8530-458563407928")
		)
		(pin "19"
			(uuid "2b5ed431-8026-4014-9b35-7648f693285c")
		)
		(pin "20"
			(uuid "6e1adc6b-82c8-4c10-a023-ced7be1f5eca")
		)
		(pin "10"
			(uuid "525e5c8c-1243-4f46-9819-0cc5f5a216de")
		)
		(pin "18"
			(uuid "3b192984-3f25-4691-8691-fe3c6363fa48")
		)
		(pin "17"
			(uuid "8a096370-25f1-4e65-a321-ec9a87f5271d")
		)
		(pin "16"
			(uuid "37db2777-040d-4bde-ba38-304f7afeba9c")
		)
		(pin "15"
			(uuid "09c115d6-b80e-411c-af6e-76b384f5575f")
		)
		(pin "14"
			(uuid "dd525137-d27e-46eb-9215-01c219d67cee")
		)
		(pin "13"
			(uuid "14ed3fad-a145-4e96-a62f-2dd8a9696201")
		)
		(pin "12"
			(uuid "3ab2c068-6b72-413c-a77e-20d37408f61b")
		)
		(pin "11"
			(uuid "e8d753bb-2934-4b93-9b60-18417bc5ba7c")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:GND")
		(at 146.05 160.02 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f949047")
		(property "Reference" "#PWR03"
			(at 146.05 166.37 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "GND"
			(at 146.177 164.4142 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 146.05 160.02 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" ""
			(at 146.05 160.02 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 146.05 160.02 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "71163886-5fb5-4006-b0e2-ac02c0d9f4c8")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#PWR03")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 120.65 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f958476")
		(property "Reference" "R1"
			(at 99.06 120.65 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 117.7036 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 118.872 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 120.65 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "ed5dc10c-bcdf-423d-b407-2024130ea425")
		)
		(pin "2"
			(uuid "5cf67ccb-e372-4fcb-ae2a-2c1f0ae9718d")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 123.19 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f958f5f")
		(property "Reference" "R2"
			(at 99.06 123.19 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 120.2436 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 121.412 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 123.19 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "18093703-cfca-48a1-b98e-b56489ff403f")
		)
		(pin "2"
			(uuid "eb2b0aba-f2cc-4311-8e08-153f73660d80")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 125.73 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f9594d6")
		(property "Reference" "R3"
			(at 99.06 125.73 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 122.7836 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 123.952 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 125.73 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "3a099bdc-6d84-4a39-b588-4a8c229d1ce8")
		)
		(pin "2"
			(uuid "5e40c26e-218e-48c5-a923-abb5428eba69")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 128.27 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f959a84")
		(property "Reference" "R4"
			(at 99.06 128.27 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 125.3236 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 126.492 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 128.27 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "287e9793-2681-4473-8f91-4ef069342fd9")
		)
		(pin "2"
			(uuid "f018827c-79db-4c3d-923f-ddb4ec03e573")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R4")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 130.81 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f95a081")
		(property "Reference" "R5"
			(at 99.06 130.81 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 127.8636 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 129.032 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 130.81 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "b870d262-3c2e-4b1c-8654-17bc58466fdc")
		)
		(pin "2"
			(uuid "17150c8d-c149-4fd0-83cb-7bb82d4ec650")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R5")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 133.35 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f95a5a7")
		(property "Reference" "R6"
			(at 99.06 133.35 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 130.4036 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 131.572 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "75c9aa6a-830c-40a7-9b3b-b4036589a0e0")
		)
		(pin "2"
			(uuid "7ea0e2ba-a636-4329-a5ea-e295a6065473")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R6")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 135.89 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f95ab3a")
		(property "Reference" "R7"
			(at 99.06 135.89 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 132.9436 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 134.112 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 135.89 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "40338ed1-2bb0-42f6-906c-e80e65bc8718")
		)
		(pin "2"
			(uuid "3e1d0c96-a125-498b-98fb-116c5b30a566")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R7")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 99.06 138.43 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f95afd8")
		(property "Reference" "R8"
			(at 99.06 138.43 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "R"
			(at 99.06 135.4836 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 99.06 136.652 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 99.06 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 99.06 138.43 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "59045afa-cdb7-479d-9384-4c68f53b76f1")
		)
		(pin "2"
			(uuid "9adef894-53bf-41ff-913e-20ecdda4c4c1")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R8")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Logic_Programmable:GAL16V8")
		(at 223.52 133.35 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005f979042")
		(property "Reference" "IC3"
			(at 223.52 110.9726 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "ATF16V8BQL"
			(at 223.52 113.284 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-20_W7.62mm_Socket_LongPads"
			(at 223.52 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" ""
			(at 223.52 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 223.52 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "10"
			(uuid "89eb9883-9fd1-4829-aabd-332fabb488c9")
		)
		(pin "1"
			(uuid "f8f3eecc-7ef2-4479-8367-d68e21e64a1e")
		)
		(pin "20"
			(uuid "f0e97d39-1d50-4aea-a394-b5dc818973c6")
		)
		(pin "2"
			(uuid "76095556-a5a9-4657-aef3-191d5fbc5cc7")
		)
		(pin "3"
			(uuid "e2597ead-99b0-4e58-a000-6d9bc65f17b0")
		)
		(pin "4"
			(uuid "8c48499a-c514-45ae-a118-812b8d03e0bb")
		)
		(pin "5"
			(uuid "21c2ecf6-3dc4-43c9-b35e-70066738ea89")
		)
		(pin "6"
			(uuid "3b63efd2-48ad-465d-af06-f7850651b0dc")
		)
		(pin "7"
			(uuid "8a18f07a-df65-48ff-9116-99b2e46209fa")
		)
		(pin "8"
			(uuid "6c22b98c-c1b0-4b91-bb5c-7f37596c7b94")
		)
		(pin "9"
			(uuid "e62bfbbc-113e-4521-9f8d-3c1d55ba022a")
		)
		(pin "11"
			(uuid "fa645f2a-4faa-405c-a362-07923fabc3bc")
		)
		(pin "19"
			(uuid "4d1dff90-fa20-4e56-9395-9913035dfb4c")
		)
		(pin "18"
			(uuid "d6b9d15f-9f05-40c6-abe6-6c131df01275")
		)
		(pin "17"
			(uuid "7d11576a-a29b-4e0c-80b6-b7bb05995a8d")
		)
		(pin "16"
			(uuid "c531c524-0512-45ef-a932-c34119418404")
		)
		(pin "15"
			(uuid "58ddebcc-345e-45e9-9e12-1216ee185633")
		)
		(pin "14"
			(uuid "4e32f2df-89fd-4815-9664-3480a7a84923")
		)
		(pin "13"
			(uuid "28ef1297-1cf1-4f7d-a13f-eb81699b63fc")
		)
		(pin "12"
			(uuid "c73a9278-f8e3-41c2-a972-90f3bb566faf")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:GND")
		(at 105.41 190.5 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00005fa8c51a")
		(property "Reference" "#PWR01"
			(at 105.41 196.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "GND"
			(at 105.537 194.8942 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 105.41 190.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" ""
			(at 105.41 190.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 105.41 190.5 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "ef823185-d9e3-43e9-8f42-c97a7ef3d1ad")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#PWR01")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 52.07 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000606027e5")
		(property "Reference" "JP5"
			(at 259.08 45.3644 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 47.6758 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
			(at 259.08 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 52.07 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a3a3acf0-321c-4fd4-9844-4ce782323b49")
		)
		(pin "2"
			(uuid "65a7571f-e960-4035-a35a-13144c6fda6a")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP5")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS245")
		(at 95.25 76.2 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006060561d")
		(property "Reference" "IC5"
			(at 95.25 51.2826 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "74HCT245"
			(at 95.25 53.594 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-20_W7.62mm_Socket_LongPads"
			(at 95.25 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "http://www.ti.com/lit/gpn/sn74LS245"
			(at 95.25 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 95.25 76.2 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "c3b2be6e-aa43-426c-ad5e-d26d78a60a42")
		)
		(pin "3"
			(uuid "04dc3e19-ca49-4ff4-aa16-f24cca11d9ec")
		)
		(pin "4"
			(uuid "df9937c1-6edc-4451-99bd-a051f343e2f2")
		)
		(pin "5"
			(uuid "025de48a-8994-48ad-8993-616bb26962b0")
		)
		(pin "6"
			(uuid "45b2e9ed-a132-4e5a-972f-093c49fb2b13")
		)
		(pin "7"
			(uuid "6ab8ca81-a4f3-49d1-a581-5acc56b951c1")
		)
		(pin "8"
			(uuid "7704dc6e-1537-4a2b-bcbe-4fa73476de13")
		)
		(pin "9"
			(uuid "9488c13b-f92c-4c46-9ba5-0f7441926053")
		)
		(pin "1"
			(uuid "6e7267f4-7b6a-40cc-8eeb-83db490d8fe9")
		)
		(pin "19"
			(uuid "d991799b-b570-4e14-bbe8-ccd0365d1692")
		)
		(pin "20"
			(uuid "4d6ae9fb-c190-4226-9562-b4c92082caaa")
		)
		(pin "10"
			(uuid "2a8b38c5-975b-4f31-b1ea-73847003fb9f")
		)
		(pin "18"
			(uuid "36fa9501-91cf-4305-879d-364f5b34bc78")
		)
		(pin "17"
			(uuid "b3130433-9dab-4e70-814c-073a9cb37416")
		)
		(pin "16"
			(uuid "ab422a91-65e3-4e57-90d7-265cea925251")
		)
		(pin "15"
			(uuid "09108c29-dd77-4e3f-b8f4-dba4e4dfc8a4")
		)
		(pin "14"
			(uuid "291f588f-2f55-49ce-921a-0b7bd14f440e")
		)
		(pin "13"
			(uuid "f2a29ecd-999d-4a15-b20a-05d3f666584d")
		)
		(pin "12"
			(uuid "ec77d25c-ad8b-48d9-86ad-26ce9302c5cd")
		)
		(pin "11"
			(uuid "73a023c6-676f-4521-b367-c9565e52c40c")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC5")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:GND")
		(at 95.25 100.33 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006061c071")
		(property "Reference" "#PWR0101"
			(at 95.25 106.68 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "GND"
			(at 95.377 104.7242 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 95.25 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" ""
			(at 95.25 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 95.25 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "dba19f81-9e87-4d4a-a3a1-98efdaf5461f")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#PWR0101")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x08_Male")
		(at 21.59 121.92 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060633b4a")
		(property "Reference" "TP1"
			(at 24.3332 109.7026 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_01x08_Male"
			(at 24.3332 112.014 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical"
			(at 21.59 121.92 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 21.59 121.92 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 21.59 121.92 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "fc5e5c70-a3a9-49a4-98bc-465c5ef96bbb")
		)
		(pin "2"
			(uuid "7c202f3c-132c-4dbc-b07f-e579eedf3e31")
		)
		(pin "3"
			(uuid "06c90627-02f2-4524-a361-22c2dbea3fa9")
		)
		(pin "4"
			(uuid "8e9a7c05-e41f-4a56-824a-4af9f9d654ef")
		)
		(pin "5"
			(uuid "365cb7d5-d926-4894-a3f5-ebd63a6810c7")
		)
		(pin "6"
			(uuid "c1160d76-e41d-422a-a4f0-d62f6cff4def")
		)
		(pin "7"
			(uuid "c4506b72-d4f9-4bbb-978f-d9e0e72bfc99")
		)
		(pin "8"
			(uuid "f131158a-f2db-4144-96f2-d62c86e5cc17")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "TP1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x08_Male")
		(at 21.59 147.32 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006063609c")
		(property "Reference" "TP2"
			(at 24.3332 135.1026 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_01x08_Male"
			(at 24.3332 137.414 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical"
			(at 21.59 147.32 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 21.59 147.32 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 21.59 147.32 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "cd177336-bfd6-4d21-9397-af020ce88ee2")
		)
		(pin "2"
			(uuid "f94e71fc-3d4a-4859-a9be-3798b901ddbb")
		)
		(pin "3"
			(uuid "a8186c8e-32b8-47e2-b7c8-d096b8762092")
		)
		(pin "4"
			(uuid "96f65baa-9741-4e5d-8bba-82cea228d1b7")
		)
		(pin "5"
			(uuid "efdb467e-d551-4656-9c13-f87f15f2abc0")
		)
		(pin "6"
			(uuid "821ba24e-3463-4cee-8b26-01e6db8bbc54")
		)
		(pin "7"
			(uuid "a6013d43-427a-4c6b-a2a8-12b6c2f36592")
		)
		(pin "8"
			(uuid "914f1fd9-7252-4cb2-b590-57e1708511c3")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "TP2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 66.04 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060636ce2")
		(property "Reference" "C6"
			(at 68.961 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 68.961 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 67.0052 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 66.04 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 66.04 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "cfae5ae2-6acb-4d51-b9ca-d4649f8b3935")
		)
		(pin "2"
			(uuid "50861a22-e37a-4c7c-ac27-31d08b15a6a0")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C6")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x24_Female")
		(at 144.78 55.88 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060646c00")
		(property "Reference" "J2"
			(at 140.97 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "Upduino_LHS"
			(at 137.16 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x24_P2.54mm_Vertical"
			(at 144.78 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 144.78 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 144.78 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "7c379ac9-a4f2-4b4e-8626-3e83f7e06ea6")
		)
		(pin "2"
			(uuid "56d6fcf6-29df-403a-8def-3cd01393c822")
		)
		(pin "3"
			(uuid "c50fb4e1-d7de-4e69-b2ff-1556b3e95790")
		)
		(pin "4"
			(uuid "bec66999-ad35-40dd-87fc-da91c326c7cc")
		)
		(pin "5"
			(uuid "c2d32cb1-0ae6-419a-a9df-fc3bf1593d78")
		)
		(pin "6"
			(uuid "7b5ceb06-9206-42b1-8c73-21fa58f50f80")
		)
		(pin "7"
			(uuid "c36b3426-480f-4641-92e6-ed381912687a")
		)
		(pin "8"
			(uuid "b682a245-53c6-4112-8aa6-1fd104623cf4")
		)
		(pin "9"
			(uuid "fad0c32c-1e9a-436c-b4c6-6d54fda5fd34")
		)
		(pin "10"
			(uuid "db76eb33-1517-4d8c-b3fa-9fdfec031400")
		)
		(pin "11"
			(uuid "03fe91ce-a149-46d4-846a-6487c420ad6b")
		)
		(pin "12"
			(uuid "c0c5c521-bf0a-4c0c-99ae-24266bb4a491")
		)
		(pin "13"
			(uuid "194a0668-b539-40a5-9b31-21969eae4d6c")
		)
		(pin "14"
			(uuid "1602d63d-4a53-4f97-95c1-fff067de536a")
		)
		(pin "15"
			(uuid "82d6dbdd-df04-43a3-bfe1-50c0c4cc5ff1")
		)
		(pin "16"
			(uuid "dc06e1dc-bfd6-4ace-9eda-123d1c11315f")
		)
		(pin "17"
			(uuid "e08b1307-2f37-4a39-bbe7-ac3f3a70cab0")
		)
		(pin "18"
			(uuid "0406f10a-404b-4fa1-9570-52740de76883")
		)
		(pin "19"
			(uuid "41f30f07-42ec-4058-a1b4-d3d6061fbf3e")
		)
		(pin "20"
			(uuid "0929983c-3759-415d-a38d-171097aba263")
		)
		(pin "21"
			(uuid "c6833e35-2f7d-433e-8f8e-b3f990aca1dc")
		)
		(pin "22"
			(uuid "909921c1-f081-4b86-a3d2-465196c32b08")
		)
		(pin "23"
			(uuid "55848d9c-ccb4-4372-a2ce-7df28fadae79")
		)
		(pin "24"
			(uuid "0308ec1e-7168-4a41-befa-af8a9acb4f5e")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x08_Male")
		(at 77.47 34.29 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006064ab6c")
		(property "Reference" "TP3"
			(at 80.2132 22.0726 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_01x08_Male"
			(at 80.2132 24.384 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical"
			(at 77.47 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 77.47 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 77.47 34.29 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "43c698b2-afec-4bbe-a972-c2a318ce1d99")
		)
		(pin "2"
			(uuid "be5b0d37-6fc0-438f-a851-26469c6ea3a0")
		)
		(pin "3"
			(uuid "555cddaa-a356-46b8-8fb6-bc6746fb1dad")
		)
		(pin "4"
			(uuid "c51cc3b8-976b-4604-94ab-3ae4f1bf6714")
		)
		(pin "5"
			(uuid "62a70361-c60e-4fae-b318-17757448cfd8")
		)
		(pin "6"
			(uuid "67653d81-cc90-4449-82d9-1f772d0598f2")
		)
		(pin "7"
			(uuid "e959828a-5c9b-4f12-9cea-001c177a1cd2")
		)
		(pin "8"
			(uuid "3a0703c2-25e5-45c2-b8fa-78628d11e5e6")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "TP3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x24_Female")
		(at 156.21 55.88 0)
		(mirror y)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006066b678")
		(property "Reference" "J3"
			(at 158.75 21.59 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Upduino_RHS"
			(at 158.75 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_1x24_P2.54mm_Vertical"
			(at 156.21 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 156.21 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 156.21 55.88 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a0fa8077-713a-4f7f-8027-ae3a82e3c693")
		)
		(pin "2"
			(uuid "393ebc11-2d15-44b1-b392-9a742165347b")
		)
		(pin "3"
			(uuid "abb0a33f-efee-48f8-ad14-643ae1447eab")
		)
		(pin "4"
			(uuid "4fa83555-4de9-4dad-8c35-02970bdddbb6")
		)
		(pin "5"
			(uuid "02744b85-0f6b-4749-a6c2-08918489044f")
		)
		(pin "6"
			(uuid "2dc0d6dc-4aae-4262-a917-88cc18693a28")
		)
		(pin "7"
			(uuid "e70a9aaa-21e3-4f58-bec1-7730b081b8e8")
		)
		(pin "8"
			(uuid "92f992f9-bd59-4115-bb79-bf32565de1b1")
		)
		(pin "9"
			(uuid "130b5bf4-3a25-42b7-89cb-0bb90967ec2a")
		)
		(pin "10"
			(uuid "dfd77536-5d88-4674-a93b-70007a4687a3")
		)
		(pin "11"
			(uuid "0c1bf5fc-e2d0-483c-9f67-d399e4e2f6d9")
		)
		(pin "12"
			(uuid "de94cb2a-a7a7-4f02-a158-238cd27f1df5")
		)
		(pin "13"
			(uuid "9c286591-6b51-43cc-a590-5968b9ff146c")
		)
		(pin "14"
			(uuid "e9189f34-a44f-400d-8f40-d191902cc227")
		)
		(pin "15"
			(uuid "e38ecb52-2ba7-445d-a914-286fef90ba54")
		)
		(pin "16"
			(uuid "0cd0f357-49b6-436c-aa32-832c72bd2137")
		)
		(pin "17"
			(uuid "0df458f2-06c9-464a-bdf1-507e73340156")
		)
		(pin "18"
			(uuid "2135c5bc-aefb-41d2-ba10-0bbd0de93901")
		)
		(pin "19"
			(uuid "3972c3d9-cdc3-4595-985f-1d53bacd89d5")
		)
		(pin "20"
			(uuid "dc30bdf6-33ca-486b-9423-f8c526369a36")
		)
		(pin "21"
			(uuid "44a321e3-66a0-497b-bc6d-e640624b9b48")
		)
		(pin "22"
			(uuid "326f56a6-a931-4db4-a186-4b6e69611428")
		)
		(pin "23"
			(uuid "f7c2f036-6258-4fe3-8f12-e243842610c8")
		)
		(pin "24"
			(uuid "ad4ba495-82c9-4ea7-881e-c5f35d5de227")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 31.75 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006066ed1b")
		(property "Reference" "JP3"
			(at 259.08 25.0444 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 27.3558 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
			(at 259.08 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 31.75 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "906ec629-2a56-4f0c-899b-90df8538c4fb")
		)
		(pin "2"
			(uuid "18e3b6d7-51bc-42c1-8225-399d3e7f4508")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP3")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 43.18 0)
		(mirror y)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060671c59")
		(property "Reference" "JP4"
			(at 259.08 36.4744 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 38.7858 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
			(at 259.08 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 43.18 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a3699688-58a0-4527-9ec6-7a7e3c474af8")
		)
		(pin "2"
			(uuid "68c962c9-ba2a-408c-bf78-d41ab2cd1eee")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP4")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector:Conn_01x06_Male")
		(at 193.04 24.13 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006068e5a7")
		(property "Reference" "J6"
			(at 195.7832 16.9926 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_01x06_Male"
			(at 195.58 15.24 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x06_P2.54mm_Vertical"
			(at 193.04 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 193.04 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 193.04 24.13 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a7c6b801-d623-4ee9-9974-8538a039781a")
		)
		(pin "2"
			(uuid "a68c502f-34c2-4890-8edc-f75730d9b294")
		)
		(pin "3"
			(uuid "16aec634-6c3e-4ef3-9d25-9102c669407b")
		)
		(pin "4"
			(uuid "7763ba51-8a10-4c51-9d7e-dffd88c2184c")
		)
		(pin "5"
			(uuid "d1daa0cc-ee9a-40d0-9c06-2c6366d2a323")
		)
		(pin "6"
			(uuid "55f003de-aca2-43e9-b22e-132195856be3")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J6")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x06_Odd_Even")
		(at 199.39 45.72 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000606c15fc")
		(property "Reference" "J4"
			(at 200.66 35.1282 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "PMOD_TOP"
			(at 200.66 37.4396 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_2x06_P2.54mm_Horizontal"
			(at 199.39 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 199.39 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 199.39 45.72 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "e820c992-d9f4-45d9-9c9b-01f999abe651")
		)
		(pin "3"
			(uuid "32d6ef89-5cbf-4691-8887-bf59ddf7dff5")
		)
		(pin "5"
			(uuid "ea2c34c1-dbef-492b-8f87-72513060828f")
		)
		(pin "7"
			(uuid "173e74f5-3c1f-43f1-9ed3-8c6c0c2c347e")
		)
		(pin "9"
			(uuid "e0a4e5b1-9e1e-442a-a79d-f0e374a805ef")
		)
		(pin "11"
			(uuid "7358eecd-a5c7-4f79-9918-69d46bf95f80")
		)
		(pin "2"
			(uuid "ba1ec6d8-24a9-45c8-97f0-af8c9ec2750a")
		)
		(pin "4"
			(uuid "aad56ef4-31c6-48ff-8188-5d656a81b38b")
		)
		(pin "6"
			(uuid "e6caafee-ab3c-4674-b653-314c2bd31134")
		)
		(pin "8"
			(uuid "d530023b-b0a8-45f7-ad59-825d199cba19")
		)
		(pin "10"
			(uuid "dc3ba566-cc37-43fa-9ad1-16c0ffaf4528")
		)
		(pin "12"
			(uuid "f8d73bbf-f0e1-41cb-adc2-95c0335fd797")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J4")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x06_Odd_Even")
		(at 199.39 69.85 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000606c93d4")
		(property "Reference" "J5"
			(at 200.66 59.2582 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "PMOD_BOTTOM"
			(at 200.66 61.5696 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_2x06_P2.54mm_Horizontal"
			(at 199.39 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 199.39 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 199.39 69.85 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "09267527-ebb3-491a-9098-13f9c5364541")
		)
		(pin "3"
			(uuid "6b070f1f-a2b3-4009-9081-a5a0f49cb059")
		)
		(pin "5"
			(uuid "8439b8d6-97fe-4fc5-a1b4-a85bb0e4add5")
		)
		(pin "7"
			(uuid "da46f933-3748-4554-ad2e-39e018e7e36d")
		)
		(pin "9"
			(uuid "470e6b03-b889-421e-a0f6-570ef2686cd6")
		)
		(pin "11"
			(uuid "defb4eec-55e9-4b45-9e1f-711aa4788e14")
		)
		(pin "2"
			(uuid "8efc009f-0a1b-4b0c-b47c-83dbc86b3e13")
		)
		(pin "4"
			(uuid "4f74bec8-820e-43c7-a271-195820c761fd")
		)
		(pin "6"
			(uuid "c2a28fd0-44f2-4c5f-805f-25bc5de29650")
		)
		(pin "8"
			(uuid "4d00b451-3df5-4fb1-adbb-4cc96685708e")
		)
		(pin "10"
			(uuid "cd7da3ce-27af-4397-aacd-18ac10715b64")
		)
		(pin "12"
			(uuid "bc6eb0c8-87dd-4966-b6fc-275a4603e67c")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J5")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:PWR_FLAG")
		(at 119.38 48.26 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006070d6ce")
		(property "Reference" "#FLG0101"
			(at 119.38 46.355 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "PWR_FLAG"
			(at 119.38 43.8658 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" ""
			(at 119.38 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 119.38 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 119.38 48.26 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a50f1aad-68a3-471c-8592-5342d0b7b7e7")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#FLG0101")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x04_Counter_Clockwise")
		(at 261.62 99.06 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060719f6c")
		(property "Reference" "J8"
			(at 262.89 91.0082 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_02x04_Counter_Clockwise"
			(at 262.89 93.3196 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_2x04_P2.54mm_Vertical"
			(at 261.62 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 261.62 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 261.62 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "f5d4d0d6-5ff9-4f7b-9706-563bf51b694b")
		)
		(pin "2"
			(uuid "ddf59ba3-0d5d-4fe5-bade-adf793052f14")
		)
		(pin "3"
			(uuid "d54a0067-4ed3-41af-8e7d-71f94c7fa728")
		)
		(pin "4"
			(uuid "1e308e23-98e5-42a3-9c56-86767bcedd5d")
		)
		(pin "8"
			(uuid "977d99d7-7949-4850-879f-25eef7233988")
		)
		(pin "7"
			(uuid "c78d1757-3362-467e-b89b-e278697bf6fc")
		)
		(pin "6"
			(uuid "8ecffc1e-b2fb-4119-af0b-dabde2986cd9")
		)
		(pin "5"
			(uuid "1d6a7c2c-7a77-4efb-9211-c5c052ab0bf3")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J8")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x04_Counter_Clockwise")
		(at 261.62 115.57 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-00006071b045")
		(property "Reference" "J7"
			(at 262.89 107.5182 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_02x04_Counter_Clockwise"
			(at 262.89 109.8296 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_2x04_P2.54mm_Vertical"
			(at 261.62 115.57 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 261.62 115.57 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 261.62 115.57 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "2cc6f355-4c57-468c-85c8-48cf3ef2b225")
		)
		(pin "2"
			(uuid "9418ad97-56ce-4ea8-921f-644c5e26236f")
		)
		(pin "3"
			(uuid "af76ddce-bc25-4e06-87a8-668e351b5fc1")
		)
		(pin "4"
			(uuid "0844d290-5733-4b74-97f9-36f70312e772")
		)
		(pin "8"
			(uuid "452e446e-46a9-483f-929a-ef97292a8c32")
		)
		(pin "7"
			(uuid "edfcf24b-83bf-48d1-8f4c-5fa98577da97")
		)
		(pin "6"
			(uuid "e8812fae-01f9-40ab-9973-9589bb9cfae6")
		)
		(pin "5"
			(uuid "02161341-0cd0-4ab1-808e-fc9d37873a04")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J7")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 118.11 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000607305dc")
		(property "Reference" "C10"
			(at 121.031 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 121.031 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 119.0752 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 118.11 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 118.11 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "60dc9db8-611e-4fad-ab4f-40790857eed5")
		)
		(pin "2"
			(uuid "07091112-f33f-45d9-bbc1-86ce33957e5c")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C10")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:C")
		(at 130.81 177.8 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000607330bc")
		(property "Reference" "C11"
			(at 133.731 176.6316 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "100nF"
			(at 133.731 178.943 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "rosco_m68k:C2.5-3"
			(at 131.7752 181.61 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 130.81 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 130.81 177.8 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "ef847b4e-dcf7-4be0-bf89-a01f965df4f9")
		)
		(pin "2"
			(uuid "e3e49f20-7749-4e71-989b-ccaed77de8f7")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "C11")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "rosco_m68k:GAL22V10")
		(at 179.07 133.35 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060cfb9dc")
		(property "Reference" "IC4"
			(at 179.07 110.9726 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "GAL22V10"
			(at 179.07 113.284 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-24_W7.62mm_LongPads"
			(at 179.07 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" ""
			(at 179.07 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 179.07 133.35 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "24"
			(uuid "d42c44be-b859-4a84-a753-84278319e916")
		)
		(pin "12"
			(uuid "3c46d1df-4871-44fb-a33e-848a03ddbefa")
		)
		(pin "1"
			(uuid "57e42fd8-f8f9-4091-bfc0-639bb0f1edf6")
		)
		(pin "2"
			(uuid "4e0af7fb-7357-4138-90fe-763a7eff4b7e")
		)
		(pin "3"
			(uuid "d1cdbf3f-8b0e-4242-a37f-9909aa6d11ee")
		)
		(pin "4"
			(uuid "f12f1108-200a-49e1-ac6b-c5bd16423265")
		)
		(pin "5"
			(uuid "37861263-520a-4052-bef3-ba48f69ace6f")
		)
		(pin "6"
			(uuid "da110e8e-57d7-4d00-9a9f-8c24a6aef9e3")
		)
		(pin "7"
			(uuid "bfc93236-d6fa-432f-b07a-48a6355ad470")
		)
		(pin "8"
			(uuid "1b903e83-5aef-4548-9a3f-7bda9979762d")
		)
		(pin "9"
			(uuid "cb9515aa-a04c-4184-8b37-6a8a4406e349")
		)
		(pin "10"
			(uuid "839abf50-41eb-49de-851b-bd45c47d1aa6")
		)
		(pin "11"
			(uuid "d7419f85-6a55-474c-9eb6-7a746186ed4c")
		)
		(pin "23"
			(uuid "0e37e3a0-dd5b-4414-947a-e010effb3201")
		)
		(pin "22"
			(uuid "29393ddf-51e3-4200-8773-9e14901bc196")
		)
		(pin "21"
			(uuid "ece078d8-c11c-41d1-8a17-61a3105233ed")
		)
		(pin "20"
			(uuid "e47fea7c-cd8b-4e19-bad4-cd2b12e5720e")
		)
		(pin "19"
			(uuid "e6eef6b0-a4f6-4807-945e-826b7cfa4185")
		)
		(pin "18"
			(uuid "a9c20ae9-29e4-4937-8319-54914d181325")
		)
		(pin "17"
			(uuid "19f0d808-34af-4eb4-8e1a-4c729a9576d2")
		)
		(pin "16"
			(uuid "3f5e3dca-f25a-47a1-a9b1-81177eb5b8a0")
		)
		(pin "15"
			(uuid "618d5867-290b-4d50-baed-d625ee6017f5")
		)
		(pin "14"
			(uuid "7c89eb9a-3cd2-45d2-be1a-86fb3c344064")
		)
		(pin "13"
			(uuid "369aff36-35a3-443f-ac66-c4fcd2b6a145")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC4")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS74")
		(at 181.61 99.06 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060d12d20")
		(property "Reference" "IC6"
			(at 181.61 86.8426 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "74LS74"
			(at 181.61 89.154 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-14_W7.62mm_Socket_LongPads"
			(at 181.61 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "74xx/74hc_hct74.pdf"
			(at 181.61 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 181.61 99.06 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "f6594346-0645-49af-be63-a4a3a21df1e7")
		)
		(pin "3"
			(uuid "e635a021-1e81-41e4-b0de-4cc8ce43f78f")
		)
		(pin "4"
			(uuid "3492306c-05a4-4f56-bf03-83326bc68ba7")
		)
		(pin "1"
			(uuid "f6d6bb34-f1f8-43e2-937c-704beea4a87d")
		)
		(pin "5"
			(uuid "199d7f26-4d08-4d9e-b20b-fc2ed1ad0ced")
		)
		(pin "6"
			(uuid "311ca538-679d-4093-8be6-687d2003c36d")
		)
		(pin "12"
			(uuid "45ba2252-323b-4073-9b6c-4340051677bc")
		)
		(pin "11"
			(uuid "cd737a85-b76b-40ad-a3d3-4c0757165feb")
		)
		(pin "10"
			(uuid "7b4fef5a-ea05-46b9-95e5-ce6601f01646")
		)
		(pin "13"
			(uuid "c31f579b-cc25-4928-a901-fc638f6ab717")
		)
		(pin "9"
			(uuid "10f86fc8-5a31-457c-9163-1734d30af406")
		)
		(pin "8"
			(uuid "eba100d6-448c-4523-82b1-5733b104782b")
		)
		(pin "14"
			(uuid "766675c5-c382-4ca9-a759-94803a3e6f24")
		)
		(pin "7"
			(uuid "fe31efd6-639e-49bd-9620-5f7254c810de")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC6")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Transistor_BJT:2N3904")
		(at 201.93 96.52 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060d18fd6")
		(property "Reference" "Q1"
			(at 206.756 95.3516 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "2N3904"
			(at 206.756 97.663 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "Package_TO_SOT_THT:TO-92_HandSolder"
			(at 207.01 98.425 0)
			(effects
				(font
					(size 1.27 1.27)
					(italic yes)
				)
				(justify left)
				(hide yes)
			)
		)
		(property "Datasheet" "https://www.fairchildsemi.com/datasheets/2N/2N3904.pdf"
			(at 201.93 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 201.93 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "8eeaa5a1-f8a8-448f-ad83-31e93c347e8e")
		)
		(pin "3"
			(uuid "85d5c897-964f-4f61-a176-8caa92fbd013")
		)
		(pin "1"
			(uuid "c3745428-2f2d-43ec-8d08-cd9a801da442")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "Q1")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:R")
		(at 193.04 96.52 270)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060d232a8")
		(property "Reference" "R9"
			(at 193.04 91.2622 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "150K"
			(at 193.04 93.5736 90)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "rosco_m68k:R-0207_10"
			(at 193.04 94.742 90)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 193.04 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 193.04 96.52 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "3aee0ea3-c865-4a40-9581-9fe02ef99459")
		)
		(pin "2"
			(uuid "a0ca133c-d7a8-47a2-85ea-2d9e927591de")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "R9")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS74")
		(at 220.98 97.79 0)
		(unit 3)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060d60650")
		(property "Reference" "IC6"
			(at 226.822 96.6216 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Value" "74LS74"
			(at 226.822 98.933 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(justify left)
			)
		)
		(property "Footprint" "Package_DIP:DIP-14_W7.62mm_Socket_LongPads"
			(at 220.98 97.79 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "74xx/74hc_hct74.pdf"
			(at 220.98 97.79 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 220.98 97.79 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "aed7dd57-7901-45ae-8626-7832f2821a32")
		)
		(pin "3"
			(uuid "bec9fc04-eef4-4b8a-b155-0f1d0fe336ae")
		)
		(pin "4"
			(uuid "f85dd6f6-5469-4d89-a019-f4b0c1e762a8")
		)
		(pin "1"
			(uuid "0883fe91-73a8-405f-9592-01b4d01d555c")
		)
		(pin "5"
			(uuid "bf14f41e-763a-4a46-af36-5815af34b807")
		)
		(pin "6"
			(uuid "68492aea-30ab-465f-80eb-9f191dea029f")
		)
		(pin "12"
			(uuid "c338c068-2828-479b-918a-6ac1477da8ed")
		)
		(pin "11"
			(uuid "e54b68b6-8c51-4448-a691-e5f2ac39d15a")
		)
		(pin "10"
			(uuid "edbb3e5e-cf68-45f3-9c3e-39898a074c0b")
		)
		(pin "13"
			(uuid "49e092b9-5f61-4e83-95fb-35becd1c79c9")
		)
		(pin "9"
			(uuid "454f2ac3-9e1e-403e-b1bd-2673aaae99f8")
		)
		(pin "8"
			(uuid "7f7db550-ac71-4d91-bed1-614447a3092b")
		)
		(pin "14"
			(uuid "1d025408-a3ab-475f-826e-0125add5c283")
		)
		(pin "7"
			(uuid "60aea763-ae87-4f59-89ee-0643aa61161b")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC6")
					(unit 3)
				)
			)
		)
	)
	(symbol
		(lib_id "74xx:74LS74")
		(at 116.84 100.33 0)
		(unit 2)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060d7c1c9")
		(property "Reference" "IC6"
			(at 116.84 88.1126 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "74LS74"
			(at 116.84 90.424 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Package_DIP:DIP-14_W7.62mm_Socket_LongPads"
			(at 116.84 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "74xx/74hc_hct74.pdf"
			(at 116.84 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 116.84 100.33 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "2"
			(uuid "a2b518f3-ceb6-4c67-8d04-4771e3165544")
		)
		(pin "3"
			(uuid "eca6c621-1922-4170-8be9-91cfc94215c0")
		)
		(pin "4"
			(uuid "df55178f-90a7-4261-b735-f4817079a202")
		)
		(pin "1"
			(uuid "f2ea768e-d4b6-49a8-a6eb-6e02c4a83479")
		)
		(pin "5"
			(uuid "40e2959d-c9be-4331-a477-74e759e871f9")
		)
		(pin "6"
			(uuid "3b1c23ad-3d30-4e5d-9883-3e14df798965")
		)
		(pin "12"
			(uuid "a949439c-2f4e-41de-984a-855db5d77c2d")
		)
		(pin "11"
			(uuid "bc1f569e-80e0-4de7-b38a-ee5525b28837")
		)
		(pin "10"
			(uuid "e8e7cf88-10c8-4d4b-9fbc-e948f4c9edbd")
		)
		(pin "13"
			(uuid "ab9ff37d-c4e9-441e-b848-98605051614e")
		)
		(pin "9"
			(uuid "8f2ae81e-4d2b-40b6-b6df-910bb5c7d7d0")
		)
		(pin "8"
			(uuid "a170911d-249d-41b6-a0f8-6d2e16319b86")
		)
		(pin "14"
			(uuid "f180b8a8-cb8a-4ddb-8a4f-e712b6d73b56")
		)
		(pin "7"
			(uuid "a8f6d006-bba9-43e1-9023-63565b15b1eb")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "IC6")
					(unit 2)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 60.96 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-000060da5e6f")
		(property "Reference" "JP6"
			(at 259.08 54.2544 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 56.5658 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical"
			(at 259.08 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 60.96 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "0ab8f805-51bc-4611-ab20-90bc08f003c9")
		)
		(pin "2"
			(uuid "8feb8656-b6c8-4613-8bc8-a896d6c950a5")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP6")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Device:Jumper")
		(at 259.08 73.66 0)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "00000000-0000-0000-0000-0000615ef646")
		(property "Reference" "JP2"
			(at 259.08 66.9544 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Jumper"
			(at 259.08 69.2658 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Jumper:SolderJumper-2_P1.3mm_Open_Pad1.0x1.5mm"
			(at 259.08 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at 259.08 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at 259.08 73.66 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "a0108f5f-5cdd-413c-8225-3753024a7cca")
		)
		(pin "2"
			(uuid "d91e4133-64c2-4dad-8371-096ed2283f44")
		)
		(instances
			(project ""
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "JP2")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "Connector_Generic:Conn_02x32_Odd_Even")
		(at -55.88 49.53 0)
		(mirror y)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "24102e30-944a-46ac-8efa-19e0ebb9ac38")
		(property "Reference" "J28"
			(at -57.15 5.08 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Value" "Conn_02x32_Odd_Even"
			(at -57.15 7.62 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(property "Footprint" "Connector_PinSocket_2.54mm:PinSocket_2x32_P2.54mm_Horizontal"
			(at -55.88 49.53 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at -55.88 49.53 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" "Generic connector, double row, 02x32, odd/even pin numbering scheme (row 1 odd numbers, row 2 even numbers), script generated (kicad-library-utils/schlib/autogen/connector/)"
			(at -55.88 49.53 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(pin "23"
			(uuid "6c975b2c-df4f-474b-aef0-3c6801345999")
		)
		(pin "20"
			(uuid "3e6fe2e2-4a40-44a1-90f6-b4238596b1a7")
		)
		(pin "49"
			(uuid "1f9d75ae-049b-45ed-a0c6-2533c28cdacd")
		)
		(pin "5"
			(uuid "3c49c7b9-4889-448e-b952-38760ae7379a")
		)
		(pin "3"
			(uuid "32fb5493-b7ed-4b57-b09e-687e80cba628")
		)
		(pin "64"
			(uuid "ea80892a-8a04-46fb-8975-9abded3ed621")
		)
		(pin "1"
			(uuid "3dfd5e39-b5f8-437a-8a08-3a2ca3e896e5")
		)
		(pin "46"
			(uuid "264fe650-d272-4759-a82d-4345d751335f")
		)
		(pin "25"
			(uuid "29ae1ff9-a403-4e4b-825e-3ee8c45ef38e")
		)
		(pin "7"
			(uuid "6bde38fa-1ba8-4fa9-9279-e1fb14266ca6")
		)
		(pin "13"
			(uuid "f943b751-8f17-4cf5-a0cb-f82a95aa1a97")
		)
		(pin "24"
			(uuid "7880786b-270f-4e13-b5dc-490c40b317bb")
		)
		(pin "18"
			(uuid "03c4eaa5-329f-4161-9192-299c1e56ecc5")
		)
		(pin "47"
			(uuid "b348d0cb-2de2-4d30-92c7-221e2a23fe17")
		)
		(pin "26"
			(uuid "ab3037db-ffae-48bf-990f-4e25209e1fa2")
		)
		(pin "2"
			(uuid "e252d947-723d-4f6f-bf03-918bb50f1e06")
		)
		(pin "22"
			(uuid "4d29b228-4ce8-496c-8a6e-17ad632c0919")
		)
		(pin "16"
			(uuid "b8c1a991-0d08-4e9c-b96f-09f96fd3ea32")
		)
		(pin "36"
			(uuid "5e35fb6a-fa68-4136-b1aa-2060b3fd7ba0")
		)
		(pin "15"
			(uuid "78657b8c-c175-495e-a0a0-41c904b810ce")
		)
		(pin "35"
			(uuid "976120b7-3dc4-44fd-a56c-0572710c2640")
		)
		(pin "33"
			(uuid "61667e55-ccae-4e62-a98c-1661af974932")
		)
		(pin "17"
			(uuid "a60bbe8f-dbd9-489a-87cd-517c00a3107e")
		)
		(pin "63"
			(uuid "4051ff1c-a416-4d8a-8f41-11244c40732c")
		)
		(pin "4"
			(uuid "27301eaa-34e4-4d09-bce8-feb097609dbf")
		)
		(pin "61"
			(uuid "ea5dd3a8-9246-4b3c-8f88-ce8d9194f530")
		)
		(pin "56"
			(uuid "a4ee5b09-1053-47fd-82cc-afb15de13a4a")
		)
		(pin "48"
			(uuid "ff0998cb-5666-46ad-b0be-ccd65acf2699")
		)
		(pin "53"
			(uuid "25766914-3b3c-437b-974c-bc0714969317")
		)
		(pin "62"
			(uuid "489d4103-49dd-4246-abee-de5c9f5b5017")
		)
		(pin "43"
			(uuid "cb853e87-7d62-4e44-81ed-bd864bd33c73")
		)
		(pin "28"
			(uuid "31434467-6f35-4b72-a7eb-f4a0cdcd9578")
		)
		(pin "57"
			(uuid "045898d6-9d00-42b0-b8cd-d65b07365dc8")
		)
		(pin "39"
			(uuid "a1f7ae08-01c6-4579-8f7e-66f77f8758c3")
		)
		(pin "21"
			(uuid "0da7664b-ee30-4f0a-a19e-190356a1e166")
		)
		(pin "58"
			(uuid "6e7de582-57cc-4d08-825f-571d391191de")
		)
		(pin "10"
			(uuid "a502d0d2-de40-4024-b640-f6977838c921")
		)
		(pin "6"
			(uuid "ad44ac7d-db3b-42f8-8653-1584e2c21f0c")
		)
		(pin "27"
			(uuid "beefbf5f-05fb-4cd5-8f6b-b03d4c3fa1ff")
		)
		(pin "19"
			(uuid "87ce5f1a-d0dc-45f5-9301-ddd7cf1af464")
		)
		(pin "59"
			(uuid "69723ded-cc2e-4a10-b136-2b988c811ed8")
		)
		(pin "29"
			(uuid "b03573e0-21b9-484f-8672-9d1fdb9039a8")
		)
		(pin "50"
			(uuid "209a381d-fcea-452c-8605-adfbca75b0ef")
		)
		(pin "12"
			(uuid "67a9c57b-653d-4e10-80b0-4b26bd53de2d")
		)
		(pin "41"
			(uuid "dbd3ba81-34e0-4241-90aa-e13843709565")
		)
		(pin "37"
			(uuid "745799ab-691a-4b89-9184-6da7f0792e41")
		)
		(pin "30"
			(uuid "323f1866-c518-4e9d-9740-f9e996384687")
		)
		(pin "45"
			(uuid "74bfec36-c44a-4437-a237-dd2a24afbc23")
		)
		(pin "8"
			(uuid "0f4ce13d-1f81-467a-858c-4a6315104739")
		)
		(pin "11"
			(uuid "cc8b8017-30c3-43a4-a3f7-466e8ba568f8")
		)
		(pin "51"
			(uuid "c7944c26-1521-4c48-a684-7e21a4b8b6cc")
		)
		(pin "9"
			(uuid "73a0ddf5-58b9-4899-8a14-5ae8dea35c4a")
		)
		(pin "55"
			(uuid "28861272-6b03-4441-ab40-a0e6fb27a704")
		)
		(pin "44"
			(uuid "0d36bedb-f8cc-40a8-a3d3-5cd322d53de5")
		)
		(pin "40"
			(uuid "582cc40a-1321-450c-9898-570ba8ccbb0d")
		)
		(pin "54"
			(uuid "374f88a0-9182-4de9-972e-d8825376fffa")
		)
		(pin "31"
			(uuid "aec4648e-18b0-4116-a65c-fffd464394a4")
		)
		(pin "60"
			(uuid "f8071d25-79a5-4cb4-9555-8f20b5e86806")
		)
		(pin "52"
			(uuid "f0eaa988-01bf-4359-b5b0-c49852b3e9b2")
		)
		(pin "14"
			(uuid "606f5439-8933-4efe-88d5-6297567be234")
		)
		(pin "34"
			(uuid "80566650-59e6-42bc-9f03-2d069963cacb")
		)
		(pin "32"
			(uuid "61869804-d44f-4315-8313-7406eefd7430")
		)
		(pin "38"
			(uuid "581071e5-cc45-484c-b1fe-ddb99f17d8de")
		)
		(pin "42"
			(uuid "9926a471-55a1-472b-87f1-c22cc5f68a3b")
		)
		(instances
			(project "xosera"
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "J28")
					(unit 1)
				)
			)
		)
	)
	(symbol
		(lib_id "power:PWR_FLAG")
		(at -77.47 90.17 180)
		(unit 1)
		(exclude_from_sim no)
		(in_bom yes)
		(on_board yes)
		(dnp no)
		(uuid "6fb7a613-47dc-48dc-a2d0-8306fb9802c8")
		(property "Reference" "#GND02"
			(at -77.47 92.075 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Value" "PWR_FLAG"
			(at -77.47 94.5642 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Footprint" ""
			(at -77.47 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Datasheet" "~"
			(at -77.47 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
				(hide yes)
			)
		)
		(property "Description" ""
			(at -77.47 90.17 0)
			(effects
				(font
					(size 1.27 1.27)
				)
			)
		)
		(pin "1"
			(uuid "11b0e94d-e1ed-40bf-9200-3e383a7fb574")
		)
		(instances
			(project "xosera"
				(path "/147ce174-3047-45a2-8664-38025ac4f072"
					(reference "#GND02")
					(unit 1)
				)
			)
		)
	)
	(sheet_instances
		(path "/"
			(page "1")
		)
	)
	(embedded_fonts no)
)
