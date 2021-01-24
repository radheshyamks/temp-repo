CC= g++ -c
OBJ= self.o
SOURCE= self.cpp
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
