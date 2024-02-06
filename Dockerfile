# Image needs to include
# - Icarus Verilog (iverilog) for simulation,
# - Verilator for linting
# - Yosys for synthesis / netlist generation

# Yosys is the best starting point since it has needed libs + Make
FROM hdlc/yosys 

# Files need to be unpacked into /usr/local
COPY --from=hdlc/pkg:verilator /verilator /
COPY --from=hdlc/pkg:iverilog /iverilog /

# tagged as verilogweb
