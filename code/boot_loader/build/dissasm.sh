#!/bin/bash
# disasm_analysis.sh - Comprehensive disassembly analysis

BINARY="program"
ELF_FILE="${BINARY}.elf"
BIN_FILE="${BINARY}.bin"
OUTPUT_DIR="disasm_analysis"

mkdir -p "$OUTPUT_DIR"

echo "=== 68000 Binary Analysis ==="

if [ -f "$ELF_FILE" ]; then
    echo "Analyzing ELF file: $ELF_FILE"
    
    # Basic information
    echo "1. File information..."
    m68k-elf-file "$ELF_FILE" > "$OUTPUT_DIR/file_info.txt"
    
    # Section headers
    echo "2. Section headers..."
    m68k-elf-readelf -S "$ELF_FILE" > "$OUTPUT_DIR/sections.txt"
    
    # Symbol table
    echo "3. Symbol table..."
    m68k-elf-nm "$ELF_FILE" > "$OUTPUT_DIR/symbols.txt"
    
    # Complete disassembly
    echo "4. Complete disassembly..."
    m68k-elf-objdump -d -S "$ELF_FILE" > "$OUTPUT_DIR/disassembly_full.txt"
    
    # Disassembly with source (if available)
    echo "5. Disassembly with source..."
    m68k-elf-objdump -d -S -l "$ELF_FILE" > "$OUTPUT_DIR/disassembly_with_source.txt"
    
    # Show relocations
    echo "6. Relocations..."
    m68k-elf-readelf -r "$ELF_FILE" > "$OUTPUT_DIR/relocations.txt"
    
    # Header information
    echo "7. ELF header..."
    m68k-elf-readelf -h "$ELF_FILE" > "$OUTPUT_DIR/elf_header.txt"
    
else
    echo "ELF file not found, analyzing binary file: $BIN_FILE"
    
    if [ -f "$BIN_FILE" ]; then
        # Raw binary disassembly
        echo "1. Raw binary disassembly..."
        m68k-elf-objdump -D -b binary -m m68k --adjust-vma=0x10000 "$BIN_FILE" > "$OUTPUT_DIR/disassembly_raw.txt"
        
        # Hex dump
        echo "2. Hex dump..."
        hexdump -C "$BIN_FILE" > "$OUTPUT_DIR/hexdump.txt"
        
        # File information
        echo "3. File information..."
        file "$BIN_FILE" > "$OUTPUT_DIR/file_info.txt"
        ls -la "$BIN_FILE" >> "$OUTPUT_DIR/file_info.txt"
    else
        echo "Error: Neither $ELF_FILE nor $BIN_FILE found!"
        exit 1
    fi
fi

# Look for interesting patterns
echo "8. Analysis patterns..."
{
    echo "=== TRAP Instructions (System Calls) ==="
    grep -n "trap" "$OUTPUT_DIR"/disassembly*.txt || echo "No TRAP instructions found"
    echo
    
    echo "=== Jump/Branch Instructions ==="
    grep -n -E "(jmp|jsr|bra|beq|bne)" "$OUTPUT_DIR"/disassembly*.txt | head -20
    echo
    
    echo "=== PC-Relative Instructions ==="
    grep -n "%pc" "$OUTPUT_DIR"/disassembly*.txt || echo "No PC-relative instructions found"
    echo
    
    echo "=== Move Instructions ==="
    grep -n "move" "$OUTPUT_DIR"/disassembly*.txt | head -10
    echo
} > "$OUTPUT_DIR/analysis_patterns.txt"

echo "Analysis complete! Files saved in: $OUTPUT_DIR/"
echo
echo "Key files:"
echo "  - disassembly_full.txt     : Complete disassembly"
echo "  - symbols.txt              : All symbols"
echo "  - sections.txt             : ELF sections"
echo "  - analysis_patterns.txt    : Interesting code patterns"
echo "  - relocations.txt          : Relocation information"

