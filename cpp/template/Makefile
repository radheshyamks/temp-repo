CC= g++ -c
OBJ= fun02.o
SOURCE= fun02.cpp
CFLAGS= 
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
