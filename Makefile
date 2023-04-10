.SUFFIXES: .c .cpp .o .mak
.PHONY: FORCE


CC = gcc
CPP = g++
#LD = gcc
LD = g++


C_MOTION = ./C-Motion
C_MOTION_C = $(C_MOTION)/C
C_MOTION_INC = $(C_MOTION)/Include

# Tell make where to look for C source files.
vpath %.c $(C_MOTION_C) ./C
vpath %.cpp $(C_MOTION_C) ./C


#OPT = -O2
#CFLAGS = -g $(OPT) -I $(C_MOTION_INC) $(CDEFS)
CFLAGS = -I $(C_MOTION_INC)
CPPFLAGS = -I $(C_MOTION_INC) -I ../ -I ./Source -I ./ -std=c++11
LDFLAGS = -g -static-libgcc 
#-static-libstdc++

obj/%.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@

obj/%.o : %.cpp
	$(CPP) -c $(CPPFLAGS) $< -o $@

obj/%.mak : %.c
	$(CC) -MM $(CFLAGS) $< > $@


c_motion_src = C-Motion.c \
       	       PMDtrans.c \
		       PMDPserLinux.c \
		       PMDdiag.c \
		       PMDutil.c \
		       PMDcommon.c \
    	       PMDopen.c \
    	       PMDPtcp.c \
    	       PMDser.c \
	
cpp_src = PMDRPdevice.cpp PMDRP.cpp PMDRPperiph.cpp		
		
	    
c_motion_obj = $(c_motion_src:%.c=obj/%.o)
## create a cpp_src variable if you need are compiling c++
cpp_obj = $(cpp_src:%.cpp=obj/%.o)

	
nIONCME: obj $(c_motion_obj) $(cpp_obj) obj/nIONCME.o 
	$(LD) $(LDFLAGS) -o $@ obj/nIONCME.o $(c_motion_obj) $(cpp_obj)
	

obj:
	mkdir obj
	mkdir obj/Source

c_motion: obj $(c_motion_obj) 

clean:
	-rm -f obj/*.o
	-rm -f obj/*.mak



