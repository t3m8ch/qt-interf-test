cmake_minimum_required(VERSION 3.21.0)

project(QtInterfTest VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Core Quick Qml)

qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

set(SOURCES
    src/main.cpp
)

set(QML_FILES
    qml/windows/WeatherWindow.qml
    qml/components/TitleBar.qml
    qml/components/Gauge.qml
    qml/components/MetadataCard.qml
    qml/components/ResizeArea.qml
    qml/components/ExitDialog.qml
    qml/components/JournalButton.qml
)

qt_add_executable(qt-interf-test-app ${SOURCES})

qt_add_qml_module(qt-interf-test-app
    URI QtInterfTest
    VERSION 0.0.1
    QML_FILES ${QML_FILES}
    RESOURCES
        fonts/Roboto.ttf
        icons/close-line.svg
        icons/stop-line.svg
        icons/subtract-line.svg
)

target_link_libraries(qt-interf-test-app PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Qml
)
