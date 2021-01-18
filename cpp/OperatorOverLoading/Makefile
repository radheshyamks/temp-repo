CC= g++ -c
OBJ= parenthesis.o
SOURCE= parenthesis.cpp
all: target
target: $(OBJ)
	g++ -o $@ $^
$(OBJ): $(SOURCE)
	$(CC) $^
.PHONY: clean run
clean:
	@echo "cleaning obj and target files..."
	@rm -rf *.o target
run:
	@./target
