CC= g++ -c
OBJ= unique_ptr.o
SOURCE= unique_ptr.cpp
all: target
target: $(OBJ)
	g++ -o $@ $^
$(OBJ): $(SOURCE)
	$(CC) $^
.PHONY: clean run
clean:
	@echo "cleaning all obj and target files..."
	@rm -rf *.o target
run:
	@./target
