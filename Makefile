CA65 = ca65
LD65 = ld65

BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
SRC_DIR := src
CFG := ue65c02-basic.cfg
INCLUDES := -I ./src/include

# --cpu wird in den AFLAGS nicht gesetzt, da .setcpu "65816" in den sources gesetzt wird (s. cpu.inc).
AFLAGS = --debug-info $(INCLUDES)
LDFLAGS = -C $(CFG) --dbgfile $(BUILD_DIR)/basic.dbg

SRCS := $(SRC_DIR)/basic.s
OBJS := $(patsubst $(SRC_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)
TARGET := $(BUILD_DIR)/basic.bin

.PHONY: all clean

all: $(TARGET)

-include $(DEPS)

$(BUILD_DIR) $(OBJ_DIR):
	@mkdir -p $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(CA65) $(AFLAGS) --create-dep $(OBJ_DIR)/$*.d $< -o $@

$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(LD65) $(LDFLAGS) -o $@ $(OBJS)

clean:
	rm -rf $(BUILD_DIR)
