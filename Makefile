# Fuck Automake
# Fuck the horse it rode in on
# and Fuck its little dog Libtool too

CC=gcc
LD=gcc

SRC = mainpanel.c multibar.c
OBJ = mainpanel.o multibar.o
GCF = `pkg-config --cflags gtk+-2.0` 

all:	
	$(MAKE) target CFLAGS="-W -O2 $(GCF)"

debug:
	$(MAKE) target CFLAGS="-g -W -D__NO_MATH_INLINES $(GCF)"

profile:
	$(MAKE) target CFLAGS="-W -pg -g -O2 $(GCF)"

clean:
	rm -f $(OBJ) *.d 

%.d: %.c
	$(CC) -M $(GCF) $< > $@.$$$$; sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; rm -f $@.$$$$

include $(SRC:.c=.d)

target: $(OBJ)
	$(LD) $(OBJ) $(CFLAGS) -o postfish `pkg-config --libs gtk+-2.0` -lpthread -lm
