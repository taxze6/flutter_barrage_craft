#include <flutter_linux/flutter_linux.h>

#include "include/flutter_barrage_craft/flutter_barrage_craft_plugin.h"

// This file exposes some plugin internals for unit testing. See
// https://github.com/flutter/flutter/issues/88724 for current limitations
// in the unit-testable API.

// Handles the getPlatformVersion method call.
FlMethodResponse *get_platform_version();
