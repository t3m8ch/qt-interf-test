# Project configuration
weather_data_app := "weather-data"
weather_control_app := "weather-control"
build_dir := "build"

red := '\033[0;31m'
green := '\033[0;32m'
yellow := '\033[1;33m'
blue := '\033[0;34m'
nc := '\033[0m'

default:
    @just help

# Check dependencies
check:
    #!/usr/bin/env bash

    set -euo pipefail

    # Check QT6
    if ! command -v qmake &> /dev/null; then
        echo -e "{{red}}[ERROR]{{nc}} Qt6 is not found in PATH"
        exit 1
    fi
    QT_VERSION=$(qmake --version | grep "Qt version" | cut -d' ' -f4)
    echo -e "{{blue}}[INFO]{{nc}} Found Qt version: $QT_VERSION"

    # Check CMake
    if ! command -v cmake &> /dev/null; then
        echo -e "{{red}}[ERROR]{{nc}} CMake is not found"
        exit 1
    fi
    CMAKE_VERSION=$(cmake --version | head -n1 | cut -d' ' -f3)
    echo -e "{{blue}}[INFO]{{nc}} Found CMake version: $CMAKE_VERSION"

    echo -e "{{green}}[SUCCESS]{{nc}} All dependencies are available"

# Setup build directory
setup:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Setting up build directory..."

    if [ -d "{{build_dir}}" ]; then
        echo -e "{{yellow}}[WARNING]{{nc}} Build directory exists. Removing old build..."
        rm -rf "{{build_dir}}"
    fi

    mkdir -p "{{build_dir}}"

    # Store current project path
    current_path=$(pwd)
    echo "$current_path" > "{{build_dir}}/.project_path"

    echo -e "{{green}}[SUCCESS]{{nc}} Build directory created"

# Check if project path changed
_check_path_change:
    #!/usr/bin/env bash
    current_path=$(pwd)
    path_file="{{build_dir}}/.project_path"

    if [ -f "$path_file" ]; then
        stored_path=$(cat "$path_file")
        if [ "$stored_path" != "$current_path" ]; then
            echo -e "{{yellow}}[WARNING]{{nc}} Project path changed from '$stored_path' to '$current_path'"
            echo -e "{{yellow}}[WARNING]{{nc}} Rebuilding CMake cache..."
            rm -rf "{{build_dir}}"
            exit 1
        fi
    fi

# Configure project
configure mode="debug":
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Configuring project..."

    cd "{{build_dir}}"

    if [ "{{mode}}" == "debug" ]; then
        cmake -DCMAKE_BUILD_TYPE=Debug ..
    elif [ "{{mode}}" == "release" ]; then
        cmake -DCMAKE_BUILD_TYPE=Release ..
    else
        cmake ..
    fi

    cd ..
    echo -e "{{green}}[SUCCESS]{{nc}} Project configured"

# Build project
build:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Building project..."

    if [ ! -d "{{build_dir}}" ]; then
        echo -e "{{red}}[ERROR]{{nc}} Build directory not found. Run 'just setup' first."
        exit 1
    fi

    cd "{{build_dir}}"
    make -j$(nproc)
    cd ..

    echo -e "{{green}}[SUCCESS]{{nc}} Project built successfully"

# Run weather data application
run-weather-data:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Running Weather Data application..."

    if [ ! -f "{{build_dir}}/{{weather_data_app}}" ]; then
        echo -e "{{red}}[ERROR]{{nc}} Weather Data executable not found. Build the project first."
        exit 1
    fi

    cd "{{build_dir}}"
    ./{{weather_data_app}}

# Run weather control application
run-weather-control:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Running Weather Control application..."

    if [ ! -f "{{build_dir}}/{{weather_control_app}}" ]; then
        echo -e "{{red}}[ERROR]{{nc}} Weather Control executable not found. Build the project first."
        exit 1
    fi

    cd "{{build_dir}}"
    ./{{weather_control_app}}

# Run both applications
run-both:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Running both applications..."

    if [ ! -f "{{build_dir}}/{{weather_data_app}}" ] || [ ! -f "{{build_dir}}/{{weather_control_app}}" ]; then
        echo -e "{{red}}[ERROR]{{nc}} One or both executables not found. Build the project first."
        exit 1
    fi

    cd "{{build_dir}}"
    echo -e "{{blue}}[INFO]{{nc}} Starting Weather Data application..."
    ./{{weather_data_app}} &
    DATA_PID=$!

    echo -e "{{blue}}[INFO]{{nc}} Starting Weather Control application..."
    ./{{weather_control_app}} &
    CONTROL_PID=$!

    echo -e "{{green}}[SUCCESS]{{nc}} Both applications started"
    echo -e "{{yellow}}[INFO]{{nc}} Weather Data PID: $DATA_PID"
    echo -e "{{yellow}}[INFO]{{nc}} Weather Control PID: $CONTROL_PID"
    echo -e "{{yellow}}[INFO]{{nc}} Press Ctrl+C to stop both applications"

    wait

# Generic run command (defaults to weather data)
run app="data":
    #!/usr/bin/env bash
    set -euo pipefail

    case "{{app}}" in
        "data"|"weather-data")
            just run-weather-data
            ;;
        "control"|"weather-control")
            just run-weather-control
            ;;
        "both"|"all")
            just run-both
            ;;
        *)
            echo -e "{{red}}[ERROR]{{nc}} Unknown application: {{app}}"
            echo -e "{{blue}}[INFO]{{nc}} Available options: data, control, both"
            exit 1
            ;;
    esac

# Clean build files
clean:
    #!/usr/bin/env bash

    echo -e "{{blue}}[INFO]{{nc}} Cleaning build files..."

    if [ -d "{{build_dir}}" ]; then
        rm -rf "{{build_dir}}"
        echo -e "{{green}}[SUCCESS]{{nc}} Build directory cleaned"
    else
        echo -e "{{yellow}}[WARNING]{{nc}} Build directory doesn't exist"
    fi

# Quick build (setup if needed + configure + build)
quick mode="debug": check
    #!/usr/bin/env bash
    set -euo pipefail

    need_setup=false

    if [ -d "{{build_dir}}" ]; then
        set +e
        just _check_path_change
        path_changed=$?
        set -e
        if [ $path_changed -eq 1 ]; then
            need_setup=true
        fi
    else
        need_setup=true
    fi

    if [ "$need_setup" = true ]; then
        just setup
        just configure {{mode}}
    fi

    just build

# Development mode (quick + run)
dev mode="debug" app="data":
    just quick {{mode}}
    just run {{app}}

# Full rebuild
rebuild mode="debug":
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Performing full rebuild..."
    just clean
    just check
    just setup
    just configure {{mode}}
    just build
    echo -e "{{green}}[SUCCESS]{{nc}} Full rebuild completed"

# Generate compile commands for IDE support
compile-commands:
    #!/usr/bin/env bash
    set -euo pipefail

    echo -e "{{blue}}[INFO]{{nc}} Generating compile commands..."

    if [ ! -d "{{build_dir}}" ]; then
        just setup
        just configure
    fi

    cd "{{build_dir}}"
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
    cd ..

    if [ -f "{{build_dir}}/compile_commands.json" ]; then
        cp "{{build_dir}}/compile_commands.json" .
        echo -e "{{green}}[SUCCESS]{{nc}} compile_commands.json generated"
    fi

# Watch files and rebuild on changes
watch app="data":
    #!/usr/bin/env bash

    if ! command -v entr &> /dev/null; then
        echo -e "{{red}}[ERROR]{{nc}} 'entr' is not installed"
        exit 1
    fi

    echo -e "{{blue}}[INFO]{{nc}} Watching for file changes... (Ctrl+C to stop)"
    find src qml CMakeLists.txt config.cmake -type f 2>/dev/null | entr -r just dev debug {{app}}

# Format code with clang-format
format:
    #!/usr/bin/env bash

    if command -v clang-format &> /dev/null; then
        echo -e "{{blue}}[INFO]{{nc}} Formatting C++ code..."
        find src -name "*.cpp" -o -name "*.h" | xargs clang-format -i
        echo -e "{{green}}[SUCCESS]{{nc}} Code formatted"
    else
        echo -e "{{yellow}}[WARNING]{{nc}} clang-format not found"
    fi

# Show project information
help:
    @echo "Qt Quick 6 Weather Applications Project"
    @echo ""
    @echo "Applications:"
    @echo "  - Weather Data: {{weather_data_app}}"
    @echo "  - Weather Control: {{weather_control_app}}"
    @echo "Build directory: {{build_dir}}"
    @echo ""
    @echo "Usage examples:"
    @echo "  just dev debug data         # Build and run weather data app"
    @echo "  just dev debug control      # Build and run weather control app"
    @echo "  just dev debug both         # Build and run both apps"
    @echo "  just run data               # Run weather data app only"
    @echo "  just run control            # Run weather control app only"
    @echo "  just run both               # Run both apps simultaneously"
    @echo "  just watch data             # Watch files and rebuild on changes"
    @echo "  just watch control          # Watch files and rebuild on changes"
    @echo "  just watch both             # Watch files and rebuild on changes"
    @echo ""
    @just --list
