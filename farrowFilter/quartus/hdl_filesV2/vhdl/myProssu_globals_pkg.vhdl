package myProssu_globals is
  -- instruction width
  constant INSTRUCTIONWIDTH : positive := 294;
  -- address width of the instruction memory
  constant IMEMADDRWIDTH : positive := 8;
  -- width of the instruction memory in MAUs
  constant IMEMWIDTHINMAUS : positive := 1;
  -- clock period
  constant PERIOD : time := 10 ns;
end myProssu_globals;
