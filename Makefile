CXX      := g++
LD       := g++

SRCDIR   := src
OBJDIR   := obj
BINDIR   := bin
EXE      := eerie

CXXFLAGS := -Wall -std=c++11 -I$(SRCDIR)
LDFLAGS  :=
LIBS     := -lglut -lGL -lGLU -lpthread

SRC      := main.cc

OBJS   := $(patsubst %.cc,$(OBJDIR)/%.o,$(SRC))
DEPS   := $(patsubst %.cc,$(OBJDIR)/%.d,$(SRC))

Q = @

ifneq ($(DEBUG),)
CXXFLAGS  += -g -pg -DDEBUG=$(DEBUG)
LDFLAGS   += -pg
endif

all: $(BINDIR)/$(EXE)

-include $(DEPS)

$(OBJDIR)/%.o: $(SRCDIR)/%.cc
	@echo "  CXX     $*.cc"
	@mkdir -p $(dir $@)
	$(Q)$(CXX) $(CXXFLAGS) -c $< -o $@
	$(Q)$(CXX) $(CXXFLAGS) -MT "$@" -MM $< > $(OBJDIR)/$*.d

$(BINDIR)/$(EXE): $(OBJS)
	@echo "  LD      $@"
	@mkdir -p $(BINDIR)
	$(Q)$(LD) -o $@ $(LDFLAGS) $(OBJS) $(LIBS)

clean:
	@rm -rf $(OBJDIR) $(BINDIR)

.PHONY: clean all
