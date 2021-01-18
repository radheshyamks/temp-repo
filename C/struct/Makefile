CC= gcc -c
OBJ= struct01.o
SOURCE= struct01.c
all: target
target: $(OBJ)
	gcc -o $@ $^
$(OBJ): $(SOURCE)
	$(CC) $^
.PHONY: clean run
clean:
	@echo "cleaning all target and object files..."
	@rm -rf *.o target
run:
	@./target
