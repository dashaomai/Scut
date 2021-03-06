
CC = cl.exe
LIBRARIAN = lib.exe
CFLAGS = /nologo /MD /W3 /GX /O2 /I . \
		/D "NDEBUG" /D "WIN32" /D "_WINDOWS" /c
LIBFLAGS = 
LDFLAGS =

OBJECTS = regexp.obj regsub.obj

all:	re_lib.lib
#all:	regr re_lib.lib

try.exe:	try.obj regexp.obj regsub.obj
	$(CC) $(LDFLAGS) /Fetry.exe try.obj regexp.obj regsub.obj

# Regression test.
regr:	try.exe tests
	@echo No news is good news...
	try < tests

re_lib.lib:	$(OBJECTS)
	$(LIBRARIAN) $(LIBFLAGS) /out:re_lib.lib $(OBJECTS)

regexp.obj:	regexp.cpp regexp.h regmagic.h
	$(CC) $(CFLAGS) regexp.cpp
regsub.obj:	regsub.cpp regexp.h regmagic.h
	$(CC) $(CFLAGS) regsub.cpp
try.obj:	try.cpp regexp.h regmagic.h
	$(CC) $(CFLAGS) try.cpp

clean: 
	-del /q $(OBJECTS) try.obj try.exe re_lib.lib re_lib.pch

