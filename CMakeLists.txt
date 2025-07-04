cmake_minimum_required(VERSION 3.21.0)

project(QtInterfTest VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Core Quick Qml)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

set(RESOURCES
    fonts/Roboto.ttf
    icons/close-line.svg
    icons/stop-line.svg
    icons/subtract-line.svg
)
qt_add_library(qt-interf-resources STATIC)
qt_add_qml_module(qt-interf-resources
    URI QtInterfTest.Resources
    VERSION 0.0.1
    RESOURCES ${RESOURCES}
    OUTPUT_DIRECTORY resources
    NO_PLUGIN
)
target_link_libraries(qt-interf-resources PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
)

set(COMPONENTS
    qml/components/TitleBar.qml
    qml/components/Gauge.qml
    qml/components/MetadataCard.qml
    qml/components/ResizeArea.qml
    qml/components/ExitDialog.qml
    qml/components/JournalButton.qml
    qml/components/BorderWithBreak.qml
)

qt_add_library(qt-interf-components ${COMPONENTS})
qt_add_qml_module(qt-interf-components
    URI QtInterfTest.Components
    VERSION 0.0.1
    QML_FILES ${COMPONENTS}
    OUTPUT_DIRECTORY components
    NO_PLUGIN
)
target_link_libraries(qt-interf-components PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
)

qt_add_executable(weather-data src/weatherData/main.cpp)
qt_add_qml_module(weather-data
    URI QtInterfTest.WeatherData
    VERSION 0.0.1
    QML_FILES qml/windows/WeatherDataWindow.qml
)
target_link_libraries(weather-data PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
    qt-interf-resources
    qt-interf-components
)

qt_add_executable(weather-control src/weatherControl/main.cpp)
qt_add_qml_module(weather-control
    URI QtInterfTest.WeatherControl
    VERSION 0.0.1
    QML_FILES qml/windows/WeatherControlWindow.qml
)
target_link_libraries(weather-control PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
    qt-interf-resources
    qt-interf-components
)
