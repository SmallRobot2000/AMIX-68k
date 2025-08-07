#!/bin/bash

# pic_checker.sh - Comprehensive Position Independence Checker for m68k
# Usage: ./pic_checker.sh program.elf

if [ $# -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    echo "Example: $0 program.elf"
    exit 1
fi

ELF_FILE="$1"
CROSS_PREFIX="m68k-elf-"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if file exists
if [ ! -f "$ELF_FILE" ]; then
    echo -e "${RED}Error: File '$ELF_FILE' not found${NC}"
    exit 1
fi

# Check if tools are available
check_tool() {
    if ! command -v "${CROSS_PREFIX}$1" &> /dev/null; then
        echo -e "${RED}Error: ${CROSS_PREFIX}$1 not found${NC}"
        exit 1
    fi
}

check_tool "readelf"
check_tool "objdump"
check_tool "nm"

echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE} Position Independence Analysis for m68k ${NC}"
echo -e "${BLUE}=========================================${NC}"
echo -e "File: ${YELLOW}$ELF_FILE${NC}"
echo

# Variables to track PIC status
IS_PIC=true
PIC_SCORE=0
TOTAL_CHECKS=0

# Function to report check results
report_check() {
    local check_name="$1"
    local result="$2"
    local details="$3"
    
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if [ "$result" = "PASS" ]; then
        echo -e "${GREEN}✓${NC} $check_name: ${GREEN}PASS${NC}"
        PIC_SCORE=$((PIC_SCORE + 1))
        if [ -n "$details" ]; then
            echo -e "  $details"
        fi
    elif [ "$result" = "FAIL" ]; then
        echo -e "${RED}✗${NC} $check_name: ${RED}FAIL${NC}"
        IS_PIC=false
        if [ -n "$details" ]; then
            echo -e "  $details"
        fi
    else
        echo -e "${YELLOW}?${NC} $check_name: ${YELLOW}UNKNOWN${NC}"
        if [ -n "$details" ]; then
            echo -e "  $details"
        fi
    fi
}

# 1. Check ELF file type
echo -e "${BLUE}1. ELF File Type Analysis${NC}"
FILE_TYPE=$(${CROSS_PREFIX}readelf -h "$ELF_FILE" | grep "Type:" | awk '{print $2}')
case "$FILE_TYPE" in
    "DYN")
        report_check "ELF File Type" "PASS" "Type: $FILE_TYPE (Position-Independent Executable)"
        ;;
    "EXEC")
        report_check "ELF File Type" "FAIL" "Type: $FILE_TYPE (Standard Executable - position dependent)"
        ;;
    *)
        report_check "ELF File Type" "UNKNOWN" "Type: $FILE_TYPE"
        ;;
esac
echo

# 2. Check for absolute relocations
echo -e "${BLUE}2. Relocation Analysis${NC}"
RELOCATIONS=$(${CROSS_PREFIX}readelf -r "$ELF_FILE" 2>/dev/null)
if [ -n "$RELOCATIONS" ]; then
    ABS_RELOCS=$(echo "$RELOCATIONS" | grep -c "R_68K_32\|R_68K_16\|R_68K_8" || true)
    PC_RELOCS=$(echo "$RELOCATIONS" | grep -c "R_68K_PC32\|R_68K_PC16\|R_68K_PC8" || true)
    GOT_RELOCS=$(echo "$RELOCATIONS" | grep -c "R_68K_GOT\|R_68K_GOTOFF" || true)
    
    if [ "$ABS_RELOCS" -eq 0 ]; then
        report_check "Absolute Relocations" "PASS" "No absolute relocations found"
    else
        report_check "Absolute Relocations" "FAIL" "$ABS_RELOCS absolute relocations found"
    fi
    
    if [ "$PC_RELOCS" -gt 0 ]; then
        report_check "PC-Relative Relocations" "PASS" "$PC_RELOCS PC-relative relocations found"
    else
        report_check "PC-Relative Relocations" "FAIL" "No PC-relative relocations found"
    fi
    
    if [ "$GOT_RELOCS" -gt 0 ]; then
        report_check "GOT Relocations" "PASS" "$GOT_RELOCS GOT-related relocations found"
    else
        report_check "GOT Relocations" "UNKNOWN" "No GOT relocations (may be OK for simple programs)"
    fi
else
    report_check "Relocations" "UNKNOWN" "No relocation information found"
fi
echo

# 3. Check for GOT and PLT sections
echo -e "${BLUE}3. Section Analysis${NC}"
SECTIONS=$(${CROSS_PREFIX}readelf -S "$ELF_FILE")

if echo "$SECTIONS" | grep -q "\.got"; then
    GOT_SIZE=$(echo "$SECTIONS" | grep "\.got" | awk '{print "0x" $6}')
    GOT_SIZE_DEC=$((GOT_SIZE))
    if [ "$GOT_SIZE_DEC" -gt 0 ]; then
        report_check "Global Offset Table (.got)" "PASS" "GOT section present ($GOT_SIZE_DEC bytes)"
    else
        report_check "Global Offset Table (.got)" "UNKNOWN" "GOT section present but empty"
    fi
else
    report_check "Global Offset Table (.got)" "FAIL" "No GOT section found"
fi

if echo "$SECTIONS" | grep -q "\.plt"; then
    report_check "Procedure Linkage Table (.plt)" "PASS" "PLT section present"
else
    report_check "Procedure Linkage Table (.plt)" "UNKNOWN" "No PLT section (may be OK for static linking)"
fi
echo

# 4. Disassembly analysis for addressing modes
echo -e "${BLUE}4. Addressing Mode Analysis${NC}"
DISASM=$(${CROSS_PREFIX}objdump -d "$ELF_FILE" 2>/dev/null)

if [ -n "$DISASM" ]; then
    # Count different addressing modes
    PC_RELATIVE=$(echo "$DISASM" | grep -c "%pc" || true)
    ABSOLUTE_ADDR=$(echo "$DISASM" | grep -c "0x[0-9a-fA-F]\{8\}" | head -1 || true)
    LEA_PC=$(echo "$DISASM" | grep -c "lea.*%pc" || true)
    JSR_PC=$(echo "$DISASM" | grep -c "jsr.*%pc" || true)
    
    if [ "$PC_RELATIVE" -gt 0 ]; then
        report_check "PC-Relative Addressing" "PASS" "$PC_RELATIVE instructions use PC-relative addressing"
    else
        report_check "PC-Relative Addressing" "FAIL" "No PC-relative addressing found"
    fi
    
    if [ "$LEA_PC" -gt 0 ]; then
        report_check "LEA with PC" "PASS" "$LEA_PC LEA instructions use PC-relative addressing"
    else
        report_check "LEA with PC" "FAIL" "No LEA instructions with PC-relative addressing"
    fi
    
    if [ "$ABSOLUTE_ADDR" -gt 10 ]; then
        report_check "Absolute Addresses" "FAIL" "Many absolute addresses found (likely position-dependent)"
    else
        report_check "Absolute Addresses" "PASS" "Few or no absolute addresses found"
    fi
else
    report_check "Disassembly Analysis" "UNKNOWN" "Could not disassemble file"
fi
echo

# 5. Symbol analysis
echo -e "${BLUE}5. Symbol Analysis${NC}"
SYMBOLS=$(${CROSS_PREFIX}nm "$ELF_FILE" 2>/dev/null)

if [ -n "$SYMBOLS" ]; then
    GOT_SYMBOLS=$(echo "$SYMBOLS" | grep -c "_GLOBAL_OFFSET_TABLE_\|_PROCEDURE_LINKAGE_TABLE_" || true)
    if [ "$GOT_SYMBOLS" -gt 0 ]; then
        report_check "PIC Symbols" "PASS" "Found PIC-related symbols (_GLOBAL_OFFSET_TABLE_)"
    else
        report_check "PIC Symbols" "FAIL" "No PIC-related symbols found"
    fi
else
    report_check "Symbol Analysis" "UNKNOWN" "Could not read symbols"
fi
echo

# 6. Check for TRAP instructions (your custom syscalls)
echo -e "${BLUE}6. System Call Analysis${NC}"
if [ -n "$DISASM" ]; then
    TRAP_COUNT=$(echo "$DISASM" | grep -c "trap.*#0" || true)
    if [ "$TRAP_COUNT" -gt 0 ]; then
        report_check "TRAP System Calls" "PASS" "$TRAP_COUNT TRAP #0 instructions found (custom syscalls)"
    else
        report_check "TRAP System Calls" "UNKNOWN" "No TRAP #0 instructions found"
    fi
else
    report_check "TRAP System Calls" "UNKNOWN" "Could not analyze system calls"
fi
echo

# 7. Check for position-dependent constructs
echo -e "${BLUE}7. Position-Dependent Code Detection${NC}"
if [ -n "$DISASM" ]; then
    # Look for common position-dependent patterns
    DIRECT_JUMPS=$(echo "$DISASM" | grep -c "jmp.*0x[0-9a-fA-F]" || true)
    DIRECT_CALLS=$(echo "$DISASM" | grep -c "jsr.*0x[0-9a-fA-F]" || true)
    MOVE_IMMEDIATE=$(echo "$DISASM" | grep -c "move.*#0x[0-9a-fA-F]\{6,\}" || true)
    
    if [ "$DIRECT_JUMPS" -eq 0 ] && [ "$DIRECT_CALLS" -eq 0 ]; then
        report_check "Direct Jumps/Calls" "PASS" "No direct absolute jumps or calls found"
    else
        report_check "Direct Jumps/Calls" "FAIL" "$DIRECT_JUMPS direct jumps, $DIRECT_CALLS direct calls found"
    fi
    
    if [ "$MOVE_IMMEDIATE" -lt 5 ]; then
        report_check "Immediate Address Loading" "PASS" "Few immediate address loads found"
    else
        report_check "Immediate Address Loading" "FAIL" "$MOVE_IMMEDIATE instructions load immediate addresses"
    fi
else
    report_check "Position-Dependent Detection" "UNKNOWN" "Could not analyze code patterns"
fi
echo

# Final assessment
echo -e "${BLUE}=========================================${NC}"
echo -e "${BLUE} FINAL ASSESSMENT ${NC}"
echo -e "${BLUE}=========================================${NC}"

PERCENTAGE=$((PIC_SCORE * 100 / TOTAL_CHECKS))

echo -e "PIC Score: ${YELLOW}${PIC_SCORE}/${TOTAL_CHECKS}${NC} (${PERCENTAGE}%)"

if [ "$IS_PIC" = true ] && [ "$PERCENTAGE" -ge 80 ]; then
    echo -e "Result: ${GREEN}POSITION INDEPENDENT${NC} ✓"
    echo -e "This code appears to be position-independent and should run at different memory addresses."
elif [ "$PERCENTAGE" -ge 60 ]; then
    echo -e "Result: ${YELLOW}PARTIALLY POSITION INDEPENDENT${NC} ?"
    echo -e "This code has some position-independent features but may have issues at different addresses."
else
    echo -e "Result: ${RED}POSITION DEPENDENT${NC} ✗"
    echo -e "This code is likely position-dependent and expects to run at a specific memory address."
fi

echo
echo -e "${BLUE}Recommendations:${NC}"
if [ "$IS_PIC" = false ]; then
    echo -e "• Compile with ${YELLOW}-fPIC${NC} or ${YELLOW}-mpcrel${NC} flags"
    echo -e "• Use PC-relative addressing: ${YELLOW}lea (data,%pc),%a0${NC}"
    echo -e "• Avoid absolute addresses in assembly code"
    echo -e "• Use GOT for global data access"
fi

if [ "$PC_RELATIVE" -eq 0 ]; then
    echo -e "• Consider using ${YELLOW}-mpcrel${NC} for full PC-relative code generation"
fi

echo
echo -e "${BLUE}Detailed Analysis Files Generated:${NC}"

# Generate detailed reports
REPORT_DIR="pic_analysis_$(basename "$ELF_FILE" .elf)"
mkdir -p "$REPORT_DIR"

echo -e "• Relocations: ${YELLOW}$REPORT_DIR/relocations.txt${NC}"
${CROSS_PREFIX}readelf -r "$ELF_FILE" > "$REPORT_DIR/relocations.txt" 2>/dev/null

echo -e "• Sections: ${YELLOW}$REPORT_DIR/sections.txt${NC}"
${CROSS_PREFIX}readelf -S "$ELF_FILE" > "$REPORT_DIR/sections.txt" 2>/dev/null

echo -e "• Disassembly: ${YELLOW}$REPORT_DIR/disassembly.txt${NC}"
${CROSS_PREFIX}objdump -d "$ELF_FILE" > "$REPORT_DIR/disassembly.txt" 2>/dev/null

echo -e "• Symbols: ${YELLOW}$REPORT_DIR/symbols.txt${NC}"
${CROSS_PREFIX}nm "$ELF_FILE" > "$REPORT_DIR/symbols.txt" 2>/dev/null

echo -e "• PC-relative instructions: ${YELLOW}$REPORT_DIR/pc_relative.txt${NC}"
echo "$DISASM" | grep "%pc" > "$REPORT_DIR/pc_relative.txt" 2>/dev/null || echo "No PC-relative instructions found" > "$REPORT_DIR/pc_relative.txt"

echo
exit 0
