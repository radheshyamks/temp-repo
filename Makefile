#<target>: <dependencies>
#<tab><commands>
#Automatic variables in Makefile
# Source, Executable, Includes, Library Defines
INCL   = loop.h defs.h
SRC    = moo.c foo.c bar.c baz.c dood.c shazbot.c mop.c woot.c
OBJ    = $(SRC:.c=.o)
LIBS   = -lgen
EXE    = moolicious

# Compiler, Linker Defines
CC      = /usr/bin/gcc
CFLAGS  = -ansi -pedantic -Wall -O2
LIBPATH = -L.
LDFLAGS = -o $(EXE) $(LIBPATH) $(LIBS)
CFDEBUG = -ansi -pedantic -Wall -g -DDEBUG $(LDFLAGS)
RM      = /bin/rm -f

# Compile and Assemble C Source Files into Object Files
%.o: %.c
       $(CC) -c $(CFLAGS) $*.c

# Link all Object Files with external Libraries into Binaries
$(EXE): $(OBJ)
       $(CC) $(LDFLAGS) $(OBJ)

# Objects depend on these Libraries
$(OBJ): $(INCL)

# Create a gdb/dbx Capable Executable with DEBUG flags turned on
debug:
	$(CC) $(CFDEBUG) $(SRC)

# Clean Up Objects, Exectuables, Dumps out of source directory
clean:
	$(RM) $(OBJ) $(EXE) core a.out
SRCS := $(wildcard *.c): $(wildcard pattern) is one of the functions for filenames. In this case, all files with the .c extension will be stored in a variable SRCS.
BINS := $(SRCS:%.c=%): This is called as substitution reference. In this case, if SRCS has values 'foo.c bar.c', BINS will have 'foo bar'
You can include other Makefiles by using the include directive.
You can create conditional syntax in Makefiles, using ifdef, ifeq, ifndef,ifneq.
You can create variables inside of Makefiles, like the $(objects) above.
Conditional Directives
The conditional directives are −

The ifeq directive begins the conditional, and specifies the condition. It contains two arguments, separated by a comma and surrounded by parentheses. Variable substitution is performed on both arguments and then they are compared. The lines of the makefile following the ifeq are obeyed if the two arguments match; otherwise they are ignored.

The ifneq directive begins the conditional, and specifies the condition. It contains two arguments, separated by a comma and surrounded by parentheses. Variable substitution is performed on both arguments and then they are compared. The lines of the makefile following the ifneq are obeyed if the two arguments do not match; otherwise they are ignored.

The ifdef directive begins the conditional, and specifies the condition. It contains single argument. If the given argument is true then condition becomes true.

The ifndef directive begins the conditional, and specifies the condition. It contains single argument. If the given argument is false then condition becomes true.

The else directive causes the following lines to be obeyed if the previous conditional failed. In the example above this means the second alternative linking command is used whenever the first alternative is not used. It is optional to have an else in a conditional.

The endif directive ends the conditional. Every conditional must end with an endif.
Syntax of Conditionals Directives
The syntax of a simple conditional with no else is as follows −

conditional-directive
   text-if-true
endif
The text-if-true may be any lines of text, to be considered as part of the makefile if the condition is true. If the condition is false, no text is used instead.

The syntax of a complex conditional is as follows −

conditional-directive
   text-if-true
else
   text-if-false
endif
If the condition is true, text-if-true is used; otherwise, text-if-false is used. The text-if-false can be any number of lines of text.

The syntax of the conditional-directive is the same whether the conditional is simple or complex. There are four different directives that test various conditions. They are as given −

ifeq (arg1, arg2)
ifeq 'arg1' 'arg2'
ifeq "arg1" "arg2"
ifeq "arg1" 'arg2'
ifeq 'arg1' "arg2"
Opposite directives of the above conditions are are follows −

ifneq (arg1, arg2)
ifneq 'arg1' 'arg2'
ifneq "arg1" "arg2"
ifneq "arg1" 'arg2'
ifneq 'arg1' "arg2"
Example of Conditionals Directives
libs_for_gcc = -lgnu
normal_libs =

foo: $(objects)
ifeq ($(CC),gcc)
   $(CC) -o foo $(objects) $(libs_for_gcc)
else
   $(CC) -o foo $(objects) $(normal_libs)
endif
The include Directive
The include directive allows make to suspend reading the current makefile and read one or more other makefiles before continuing. The directive is a line in the makefile that looks follows −

include filenames...
The filenames can contain shell file name patterns. Extra spaces are allowed and ignored at the beginning of the line, but a tab is not allowed. For example, if you have three `.mk' files, namely, `a.mk', `b.mk', and `c.mk', and $(bar) then it expands to bish bash, and then the following expression.

include foo *.mk $(bar)

is equivalent to:

include foo a.mk b.mk c.mk bish bash
When the make processes an include directive, it suspends reading of the makefile and reads from each listed file in turn. When that is finished, make resumes reading the makefile in which the directive appears.

The override Directive
If a variable has been set with a command argument, then ordinary assignments in the makefile are ignored. If you want to set the variable in the makefile even though it was set with a command argument, you can use an override directive, which is a line that looks follows−

override variable = value

or

override variable := value
Make uses a special target, named .SUFFIXES to allow you to define your own suffixes. For example, refer the dependency line given below −

.SUFFIXES: .foo .bar
It informs make that you will be using these special suffixes to make your own rules.

Similar to how make already knows how to make a .o file from a .c file, you can define rules in the following manner −

.foo.bar:
	tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]' < $< > $@
.c.o:
	$(CC) $(CFLAGS) -c $<
The first rule allows you to create a .bar file from a .foo file. It basically scrambles the file. The second rule is the default rule used by make to create a .o file from a .c file.
Make terminates if any command returns a failure status. The following rule will be shown in such case −

clean:
	-rm *.o *~ core paper
Make ignores the returned status on command lines that begin with a dash. For example, who cares if there is no core file?

Make echoes the commands, after macro substitution to show you what is happening. Sometimes you might want to turn that off. For example −

install:
	@echo You must be root to install
People have come to expect certain targets in Makefiles. You should always browse first. However, it is reasonable to expect that the targets all (or just make), install, and clean is found.

make all − It compiles everything so that you can do local testing before installing applications.

make install − It installs applications at right places.

make clean − It cleans applications, gets rid of the executables, any temporary files, object files, etc.
Sr.No	Variables & Description
1 AR
Archive-maintaining program; default is `ar'.
2 AS
Program to compiling assembly files; default is `as'.
3 CC
Program to compiling C programs; default is `cc'.
4 CO
Program to checking out files from RCS; default is `co'.
5 CXX
Program to compiling C++ programs; default is `g++'.
6 CPP
Program to running the C preprocessor, with results to standard output; default is `$(CC) -E'.
7 FC
Program to compiling or preprocessing Fortran and Ratfor programs; default is `f77'.
8 GET
Program to extract a file from SCCS; default is `get'.
9 LEX
Program to use to turn Lex grammars into source code; default is `lex'.
10 YACC
Program to use to turn Yacc grammars into source code; default is `yacc'.
11 LINT
Program to use to run lint on source code; default is `lint'.
12 M2C
Program to use to compile Modula-2 source code; default is `m2c'.
13 PC
Program for compile Pascal programs; default is `pc'.
14 MAKEINFO
Program to convert a Texinfo source file into an Info file; default is `makeinfo'.
15 TEX
Program to make TeX dvi files from TeX source; default is `tex'.
16 TEXI2DVI
Program to make TeX dvi files from Texinfo source; default is `texi2dvi'.
17 WEAVE
Program to translate Web into TeX; default is `weave'.
18 CWEAVE
Program to translate C Web into TeX; default is `cweave'.
19 TANGLE
Program to translate Web into Pascal; default is `tangle'.
20 CTANGLE
Program to translate C Web into C; default is `ctangle'.
21 RM
Command to remove a file; default is `rm -f'.

Sr.No.	Variables & Description
1 ARFLAGS
Flags to give the archive-maintaining program; default is `rv'.
2 ASFLAGS
Extra flags to give to the assembler when explicitly invoked on a `.s' or `.S' file.
3 CFLAGS
Extra flags to give to the C compiler.
4 CXXFLAGS
Extra flags to give to the C compiler.
5 COFLAGS
Extra flags to give to the RCS co program.
6 CPPFLAGS
Extra flags to give to the C preprocessor and programs, which use it (such as C and Fortran compilers).
7 FFLAGS
Extra flags to give to the Fortran compiler.
8 GFLAGS
Extra flags to give to the SCCS get program.
9 LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker, `ld'.
10 LFLAGS
Extra flags to give to Lex.
11 YFLAGS
Extra flags to give to the Pascal compiler.
13 RFLAGS
Extra flags to give to the Fortran compiler for Ratfor programs.
14 LINTFLAGS
Extra flags to give to lint.
NOTE − You can cancel all variables used by implicit rules with the '-R' or '--no-builtin-variables' option.
You can also define macros at the command line as shown below −
make CPP = /home/courses/cop4530/spring02

$@ ->$@ is the name of the target. This allows you to easily write a generic action that can be used for multiple different targets that produce different output files. For example, the following two targets produce output files named client and server respectively.
$^-> $^ gives you all dependencies, regardless of whether they are more recent than the target. Duplicate names, however, will be removed. This might be useful if you produce transient output (such as displaying a result to the screen rather than saving it to a file).
$< -> If you only need the first dependency, then $< is for you. Using $< can be safer than relying on $^ when you have only a single dependency that needs to appear in the commands executed by the target. If you start by using $^ when you have a single dependency, if you then add a second, it may be problematic, whereas if you had used $< from the beginning, it will continue to work. (Of course, you may want to have all dependencies show up. Consider your needs carefully.)
$? ->The $? macro stores the list of dependents more recent than the target (i.e., those that have changed since the last time make was invoked for the given target). We can use this to make the build commands from the above example even more general:
$+ -> $+ is like $^, but it keeps duplicates and gives you the entire list of dependencies in the order they appear.
#It is possible to create a new macro based on replacing part of an old macro. For instance, given a list of source files, called SRC, you might wish to generate the corresponding object files, stored in a macro called OBJ. To do so, you can specify that OBJ is equivalent to SRC, except with the .c extension replaced with a .o extension:
#1
OBJ = $(SRC:.c=.o)
#Note that this is effectively saying that in the macro SRC, .c should be replaced with .o.
#Wildcard Matching in Targets (Pattern Rules)
#The percent sign, %, can be used to perform wildcard matching to write more general targets; when a % appears in the dependencies list, it replaces the same string of text throughout the command in makefile target. If you wish to use the matched text in the target itself, use the special variable $*. For instance, the following example will let you type make <name of .c file> to build an executable file with the given name:
#1
#2
%:
	gcc -o $* $*.c
%.o: %.cpp
    	$(CXX) $(CXXFLAGS) -c $(input) -o $(output)
	Phony targets
Often it is convenient to put commands into the makefile that don't actually build a file, but are somehow logically associated with the build process. For example, a very common procedure in makefiles is something like this:

    prefix=/usr/local

    install: our_program
    	install -m 0755 our_program $(prefix)/bin
    	install -m 0644 *.png $(prefix)/share/our_program/icons

    .PHONY: install

When someone types makepp install, then makepp first builds our_program, then runs the commands associated with the install target. The install command simply copies its arguments to the specified directory, and sets the file's protection to the indicated value. So it copies our_program into /usr/local/bin, and some associated data files into /usr/local/share/our_program/icons. But this doesn't create a file called install in the current directory.

The install target here is called a phony target because makepp treats it as if it were a real file, but it is not actually a file, it's just a trick for forcing makepp to build its dependencies and then run some commands.

That's what the line .PHONY: install

is for. It tells makepp that it really shouldn't expect the file ./install to exist after the commands have executed. If you forget the phony declaration, then makepp will expect the file install to exist after executing the commands, and it will complain loudly if it does not.

You can also write the phony declaration like this: $(phony install): our_program ...

and then omit the .PHONY: install line. This means that you can declare the target as phony on the same line as you define it, which may make your makefiles more readable.

Phony targets are extremely common in makefiles. In almost all makefiles, the first target is the phony target all, like this:

    $(phony all): program1 program2 program3

If no target is specified on the command line, makepp attempts to build the first target in the file. If your makefile makes more than just one program, you most likely want to build all of the programs by default. In this example, if the programmer just types makepp without any arguments, makepp attempts to build all, which forces it to build all three programs from this directory.

Here is a sample makefile fragment that illustrates some commonly used phony targets:

PROGRAMS	:= combobulator discombobulator

$(phony all): $(PROGRAMS)	# All is the first target, so it's the default.

combobulator: $(COMBOBULATOR_OBJS)
$(CXX) $(inputs) -o $(output)

discombobulator: $(DISCOMBOBULATOR_OBJS)
$(CXX) $(inputs) -o $(output)

#
# This target makes sure everything is compiled, and then puts the
# programs into a place where everyone can access them.  We make the
# directories if they don't exist yet.
#
prefix	:= /usr/local

$(phony install): all
test -d $(prefix) || mkdir $(prefix)
test -d $(prefix)/bin || mkdir $(prefix)/bin
for prog in $(PROGRAMS); do \
  install -m 0755 $$prog $(prefix)/bin; \
done
test -d $(prefix)/share || mkdir $(prefix)/share
test -d $(prefix)/share/combobulate || mkdir -p $(prefix)/share/combobulate
for icon in *.xbm; do \
  install -m 0644 $$icon $(prefix)/share/combobulate; \
done
# Note the use of the double dollar sign to pass a single dollar sign to
# the shell.  Note also the backslashes at the end of a line to indicate
# that a shell command continues to the next line.

#
# This target gets rid of all the junk that gets built during compiles.
# (Note that this could be done more thoroughly with the only_targets
# function.)
#
$(phony clean):
rm -f $(PROGRAMS) *.o

#
# This target makes a source distribution for shipping out to someone.
#
VERSION := 3.14

$(phony distribution):
rm -rf combobulate-$(VERSION)	# Get rid of previous junk, if any.
mkdir combobulate-$(VERSION)
cp *.c *.h Makefile README INSTALL combobulate-$(VERSION)
tar cf - combobulate-$(VERSION) | gzip -9c > combobulate-$(VERSION).tar.gz
rm -rf combobulate-$(VERSION)

#
# This target runs regression tests to make sure the program(s) are
# doing what they are supposed to do.
#
$(phony test): $(PROGRAMS)
noecho for testfile in *.test; do \
   ./combobulate $$testfile | ./discombobulate - > junk_output; \
  if cmp -s junk_output $$testfile; then \
    echo passed $$testfile; \
  else \
    echo failed $$testfile; \
  fi; \
done
#
# If "noecho" is the first word of the action, the action itself is not
# printed before it is executed.  In this case, printing the action
# would merely clutter up the screen so it is very common to suppress
# printing for such long commands.
#
Working with several directories
If your program grows to a substantial size, or if it uses libraries that need to be built but should be kept separate, it is quite likely that you have split up your sources into several directories. One of the main motivations for writing makepp was to make dealing with several directories much easier than with the standard make utility. If you're familiar with the standard unix make, you'll notice that with makepp, you don't have to mess around with ugly complexities like recursive invocations of make.

With makepp, you simply put a separate makefile in each directory that builds the relevant files in that directory. When a makefile refers to files whose build commands are in different makefiles, makepp automatically finds the appropriate build rules in the other makefiles. All actions in each makefile are executed with the current directory set to be the directory containing the makefile, so each makefile can be written independently of all the others. No makefile has to know anything about the other makefiles; it does not even have to tell makepp to load the rules from those other makefiles.

When you've written your makefiles, cd to the directory that contains your main program, and type makepp just like you usually would. Makepp will load in the makefile from that directory. It will notice that this makefile refers to files in other directories, and it will examine those other directories to see if there is a makefile in them. In this way, all relevant makefiles will be loaded.

As a simple example, suppose your top level directory contains the following makefile:

    # Top level makefile:
    
    CXX	:= c++
    CXXFLAGS := -O2
    my_program: main.o goodies/libgoodies.so
    	$(CXX) $(inputs) -o $(output)
    
    %.o: %.cxx
    	$(CXX) $(CXXFLAGS) -c $(input) -o $(output)

You would need to write a makefile in the directory goodies which builds libgoodies.so, like this:

    # goodies/Makefile
    
    CXX	:= c++
    CXXFLAGS := -O2
    
    MODULES = candy.o chips.o licorice.o cookies.o popcorn.o spinach.o
    
    libgoodies.so: $(MODULES)
    	$(CXX) -shared $(inputs) -o $(output)
    			# Note that the command is written assuming that
    			# the current directory is the subdirectory
    			# "goodies", not the top level subdirectory.
    			# Makepp cds into this directory before executing
    			# any commands from this makefile.
    
    %.o: %.cxx
    	$(CXX) $(CXXFLAGS) -fpic -c $(input) -o $(output)

And that's all you need to do.

Any variables which you specify on the command line override the definition of the variable in all makefiles. Thus, for example, if you type makepp CXXFLAGS="-g", all modules will be recompiled for debug because the definition of CXXFLAGS in both makefiles is overridden.

The directories containing other sources need not be subdirectories of the top-level directory (as they are in this example). They can be anywhere in the file system; makepp will automatically load a makefile from any directory that contains a file which is a dependency of some target it is trying to build. It will also load a makefile from any directory that is scanned by a wildcard.

Automatic loading works if files built by your makefile all reside in the same directory as the makefile itself. If you write your makefile so that its rules produce files in a different directory than the makefile itself, then you might have to tell makepp where to look for the makefiles, since it doesn't have any way of guessing. You can do this using the load_makefile statement in your makefile. For more information about this and other issues related to multi-directory builds, see makepp_cookbook/Tips for multiple directories.

One caveat: if you reference the variable $(MAKE) in your makefile, makepp automatically goes into backward compatibility mode and turns off automatic loading.

Template or boilerplate files
Makepp has several other features which make life slightly easier for programmers who have to maintain a program spanning several directories. In the above examples, you'll notice that the definitions of the variables CXX and CXXFLAGS have to be repeated in each makefile. It can be a nuisance to reenter the same information into every makefile, and it could be a problem if you ever decide to change it--you may have to modify dozens of different makefiles.
What you can do instead is to put all of the information that's common to each makefile into a separate file, located perhaps at the top of the directory tree. Common information usually includes variable definitions, and sometimes also pattern rules. (In the above example, however, the pattern rules are not the same in both makefiles.) Let's suppose you've called this file standard_defs.mk. Then each makefile simply needs to contain a statement like this:

    include standard_defs.mk

When makepp sees this statement, it inserts the contents of the file into the makefile at that point. The include statement first looks for the file in the current directory, then in the parent of the current directory, and so on up to the top level of the file system, so you don't actually need to specify ../standard_defs.mk or ../../../../standard_defs.mk.

So we could rewrite the above makefiles to look like this. standard_defs.mk would exist in the top level directory, and it might contain the following definitions:

    # standard_defs.mk
    CXX	:= c++
    CXXFLAGS := -O2
    
    #
    # We've also included a pattern rule that might be useful in one or more
    # subdirectories.  This pattern rule is for C compilation for putting
    # things into a shared library (that's what the -fpic option is for).
    #
    %.o: %.cxx
    	$(CXX) $(CXXFLAGS) -fpic -c $(input) -o $(output)

Note that since the included file is actually inserted into each makefile, rules in the included file are applied with the default directory set to the directory containing the makefile that included the file, not the directory containing the include file.

The top level Makefile might look like this:

    # Top level makefile
    include standard_defs.mk
    
    my_program: main.o goodies/libgoodies.so
    	$(CXX) $(inputs) -o $(output)
    
    #
    # Note that this pattern rule overrides the one found in standard_defs.mk,
    # because makepp sees it later.  This pattern rule is for compilation for
    # a module that doesn't belong in a shared library.
    #
    %.o: %.cxx
    	$(CXX) $(CXXFLAGS) $(input) -o $(output)

And the subdirectory's makefile might look like this:

    # goodies/Makefile
    include standard_defs.mk
    
    MODULES = candy.o chips.o licorice.o cookies.o popcorn.o spinach.o
    
    libgoodies.so: $(MODULES)
    	$(CXX) -shared $(inputs) -o $(output)
    
    # We don't need the pattern rule for compilation of .cxx to .o files, 
    # because it's contained in standard_defs.mk.

The -F compilation option
If you run makepp from within an editor such as emacs, and you are editing sources from several different directories, you may find that the default directory for makepp differs depending on which file you were most recently editing. As a result, makepp may not load the correct makefile.

What you can do to ensure that makepp always loads the correct makefile(s), no matter what directory happens to be your current directory, is to use the -F command line option, like this:

    makepp -F ~/src/my_program

Makepp will first cd to the directory ~/src/my_program before it attempts to load a makefile.

Using Wildcards
Up until this point, we've had to explicitly list all of the modules that go into a program or a library. The previous makefile, for example, contained this line:

    MODULES = candy.o chips.o licorice.o cookies.o popcorn.o spinach.o
    
    libgoodies.so: $(MODULES)
    	$(CXX) -shared $(inputs) -o $(output)

In this case, listing all of the modules that go into libgoodies.so is not such a big deal since there aren't very many of them. But sometimes it can be a real nuisance to list all of the object files, especially if this list is changing rapidly during development. Frequently, you want every single module in the whole directory to be compiled into your program or library. It would be a lot easier if you could just tell makepp to do that without listing them all.

Well, you can. The above lines could be rewritten as:

    libgoodies.so: *.o
    	$(CXX) -shared $(inputs) -o $(output)

The *.o wildcard matches any existing .o files, or any .o files which do not yet exist but can be made by any of the rules that makepp knows about from any makefiles that it has read. So the wildcard will return the same list of files, no matter whether you haven't compiled anything yet, or whether all the modules have been compiled before.

Of course, if you contaminate your directories with extra files that shouldn't be compiled directly into your library, (e.g., if you write little test programs and leave them in same directory as the library source files), then these modules will be incorrectly included into your library. If you choose to use wildcards, it's up to you to keep the directory clean enough.

Makepp supports the usual unix wildcards and one additional one:

Matches any string of 0 or more characters. It will not match the / character. For example, a*c matches ac, abc, and aaaaabc, but not aa/bc.
Matches exactly one character (not including /). For example, ???.o matches all filenames that have 3 characters before the .o extension.
Matches any of a list of characters at that position. For example, [abc].o matches a.o, b.o, c.o, but not abc.o or d.o. You can also specify a range of characters, e.g., data_[0-9] will match data_0, data_1, etc.
This is a special wildcard, found only in makepp (and the zsh shell, from which I stole the idea). It matches any number of intervening directories. For example, **/*.o matches xyz.o, test_programs/abc.o, and a/deeply/nested/subdirectory/def.o.
If your sources are contained in several subdirectories, and you want to link all the object modules together, you could write it like this:

    liboodles.so: **/*.o
    	$(CXX) -shared $(inputs) -o $(output)

Functions and Advanced Variable Usage
Makepp has a number of extremely powerful ways of manipulating text. This tutorial shows a few of the more useful ways, but you might want to glance through makepp_variables and makepp_functions for a more complete list.

Lists of corresponding files
A common problem in makefiles is the maintenance of two lists of files which correspond. Consider the following two variables:
    SOURCES := a.cpp bc.cpp def.cpp
    OBJS := a.o bc.o def.o

We might want to have a list of sources if the makefile can build source distributions, and we might need a list of objects for the link command. It's tedious to change both lines whenever a new module is added, and it's not unlikely that a programmer will change one line and forget to change the other. Here we will show four different ways to avoid the duplication.

The patsubst function
The first is to use makepp's functions to convert one list into another. A function invocation looks a little like a variable, except that a function can take arguments:
    $(function arg1 arg2 arg3 ...)

Makepp supplies many powerful functions, but probably the most useful of them is the patsubst function. You could write the above lines like this:

    SOURCES = a.cpp bc.cpp def.cpp
    OBJS = $(patsubst %.cpp, %.o, $(SOURCES))

The patsubst function applies a pattern to every word in a list of words, and performs a simple textual substitution. Any words in the list that match the pattern in the first argument are put into the output after making the substitution indicated by the second argument. The % wildcard matches any string of 0 or more characters. In this example, the pattern %.cpp is applied to every word in $(SOURCES). The first word, a.cpp matches the pattern, and the % wildcard matches the string a. The % in the second argument is then replaced by a, and the result is a.o. For the second argument, % matches bc, so the result is bc.o.

Makepp's functions can strip directory names, remove extensions, filter out matching words, return the output from shell commands, and other useful tricks. In addition, you can also write your own functions in perl that can be called from other parts of the makefile. See makepp_extending for details.

Substitution references
Since the patsubst function is so common, there is an abbreviated syntax for it called a substitution reference. We could have written the above lines like this:
    SOURCES = a.cpp bc.cpp def.cpp
    OBJS = $(SOURCES:%.cpp=%.o)

rc-style substitution
Sometimes invocations of patsubst or the equivalent substitution references can be somewhat cryptic. Makepp provides another option which is sometimes more convenient: i<rc-style substitution (so called because it was pioneered by the rc shell).
    MODULES := a bc def
    SOURCES := $(MODULES).cpp
    OBJS := $(MODULES).o

What happened here is that when it evaluated $(MODULES).cpp, makepp appended .cpp to every word in $(MODULES), and similarly for $(MODULES).o. In general, any characters preceding the $(variable) (up to a word delimiter) are placed before each word in $(variable), and any characters following $(variable) are placed after each word in $(variable). Thus the result of evaluating x$(MODULES)y would be xay xbcy xdefy.

Inline perl code
If you know perl, you can insert perl code to perform arbitrary manipulations on variables into your makefile. This is best illustrated by an example:
    SOURCES := a.cpp bc.cpp def.cpp
    perl_begin
    ($OBJS = $SOURCES) =~ s/\.cpp/.o/g;
    perl_end

Any text between the perl_begin statement and the perl_end statement is passed off to the perl interpreter. All variables in the makefile (except automatic variables) are accessible as perl scalars. Any variables you set with perl code will be accessible in the makefile.

So what the above example does is to copy the text from $SOURCES to $OBJS, then substitute each occurence of .cpp with .o.

In this example, using inline perl code is probably unnecessary since there are easier and clearer ways of doing the same manipulation. But the full power of the perl interpreter is available if you need it.

Source/Object Separation and Variant Builds
Up to this point all of the makefiles we have seen put the object files in the same directory as the source files. This is usually the way makefiles are written, and it's certainly the simplest way to do things. However, suppose you have to compile your program on both a linux machine and a Solaris machine. The binaries from the two machines are incompatible, of course. Unlike the traditional make, makepp is smart enough to know that if the last compilation was on linux, and the current compilation is on Solaris, a recompilation of everything is necessary.

But this still leaves a problem: when you recompile on Solaris, you wipe out your linux binaries. Then when you switch back to linux, you have to recompile everything again, even though the source files that haven't changed.

A related problem is if you build your program with several different options. Suppose for example that you usually compile your program with optimization:

    CFLAGS	:= -O2
    
    %.o: %.c
    	$(CC) $(CFLAGS) -c $(input) -o $(output)
    
    my_program: *.o
    	$(CC) $(inputs) -o $(output)

However, you discover a bug, and you want to enable debugging on all files, so you do change CFLAGS:

    CFLAGS	:= -g -DMALLOC_DEBUG

Makepp realizes that the build commands have changed, and it needs to recompile everything. But again, recompiling with debugging enabled wipes out your old binaries, so if you want to turn optimization back on, everything must be recompiled again, even the files that haven't changed.

The obvious solution to these problems is to put the architecture-dependent or build-variant-dependent files in a separate subdirectory. There are two basic techniques for doing this: explicitly specifying an alternate directory, or using repositories.

Explicit specifications of alternate directories
You could rewrite the rules in your makefile to dump the objects into a different directory, like this:

    ARCH	:= $(shell uname -m)	# ARCH becomes the output from the uname -m command.
    CFLAGS	:= -O2
    OBJDIR	:= $(ARCH)-optim
    
    $(OBJDIR)/%.o: %.c
    	$(CC) $(CFLAGS) -c $(input) -o $(output)
    
    $(OBJDIR)/my_program: $(OBJDIR)/*.o
    	$(CC) $(inputs) -o $(output)

Now when you run makepp, ARCH is automatically set to something different for each architecture, and all of the objects are placed in a different directory for each architecture, so they don't overwrite each other. If you want to recompile turning on debugging, then you would have to change both CFLAGS and OBJDIR.

One problem with this approach is that implicit loading will no longer work. The only place that makepp knows to look for a makefile when it needs to build something is in the directory of the file it's trying to build. If this is a problem for you, then you can explicitly tell makepp where to look using the load_makefile statement.

Repositories
Repositories are a magical way of using a makefile that is written to put objects in the same directory, but having makepp automatically put the objects in a different directory. Suppose we start with the original makefile above (before we modified it to put the objects in a different directory), and we've been working on linux so our source directory is filled with linux binaries. When we want to recompile our code on solaris instead of linux, we use the following command instead of just typing makepp:

    % mkdir solaris
    % cd solaris
    % makepp -R ..

What the -R option to makepp does in this case is to declare the directory .. (which is the original source directory) as a repository. A repository is just a way of getting makepp to trick all of the actions into believing that all files in one directory tree are actually located in a different directory tree in the file system. In the above example, makepp pretends that all the files in .. (and all subdirectories of ..) are actually in the current directory (and corresponding subdirectories).

More precisely, a repository is a place where makepp looks if it needs to find a file that doesn't exist in the current directory tree. If the file exists in the current directory tree, it is used; if it doesn't exist, but a file exists in the repository, makepp makes a temporary symbolic link from the file in the repository to the current directory. (A symbolic link is an alias for the original file. It's like a copy, except that trying to access the link actually accesses the original file.) The rule actions then act on the file in the current directory, but actually reference the files in the repository.

In this example, initially we start off with a blank new directory solaris. (It doesn't have to be blank, of course, and it won't be the second time you run makepp.) Makepp is run in this directory, and it sees that there is no makefile there. However, there is a makefile in the repository, so it links in the one from the repository, and reads it. The pattern rule in the makefile that converts .c files into .o files causes makepp to link all the .c files that it needs from the repository, and run the compilation command from the solaris subdirectory. Therefore the .o files are now placed into the solaris subdirectory, not in the top level directory. When the build command is finished, any files linked from the repository are deleted, so the solaris subdirectory will contain only the binary files for Solaris. Any .o files that exist in the repository are unmodified, so when you go back to your linux machine and rerun makepp, most of your program will not have to be recompiled.

Sometimes it might be more convenient to use a different form of the repository command. The above three shell commands could be entirely replaced by the following one command:

    % makepp -R solaris=. -F solaris

What this does is to say that the files in the current directory are to be linked into the solaris subdirectory as necessary. (The solaris subdirectory will be created automatically if it does not exist.) Then the -F option causes makepp to cd to the solaris directory and execute the makefile there (which will be linked from the repository).

Using a repository does not have the same drawbacks as explicitly specifying an object directory; makefiles will be implicitly loaded as expected, since as far as makepp is concerned, the makefile actually is in the same directory as the target files. However, if your build involves not just one but several directory trees, using repositories can become quite complicated.

Repositories are just a way of pretending that things located at one place in the file system are actually in a different place for the duration of the build. This is a very powerful technique that can be used for more than just separating your sources and binaries
