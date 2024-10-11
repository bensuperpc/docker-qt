cmake_minimum_required(VERSION 3.14)

project(
    test_qt_qml
    VERSION 2.0.0
    DESCRIPTION ""
    HOMEPAGE_URL "https://github.com/bensuperpc"
    LANGUAGES C CXX
)

# Replace DataVisualization by Charts
# WebEngine is disabled by default
find_package(QT NAMES Qt6 COMPONENTS Quick QuickControls2 Gui Core Qml Charts Multimedia Widgets Concurrent SerialPort 
    VirtualKeyboard LinguistTools Test Network Sql Xml OpenGL Sensors Bluetooth DBus Graphs Quick3D Positioning Coap Mqtt 
    NetworkAuth RemoteObjects TextToSpeech WebSockets Svg Location Nfc SerialBus WebChannel REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick QuickControls2 Gui Core Qml Charts Multimedia Widgets Concurrent SerialPort 
    VirtualKeyboard LinguistTools Test Network Sql Xml OpenGL Sensors Bluetooth DBus Graphs Quick3D Positioning Coap Mqtt 
    NetworkAuth RemoteObjects TextToSpeech WebSockets Svg Location Nfc SerialBus WebChannel REQUIRED)

if (Qt${QT_VERSION_MAJOR}_FOUND)
    if (Qt${QT_VERSION_MAJOR}_VERSION VERSION_GREATER_EQUAL 6.3)
        qt_standard_project_setup()
    else()
        set(CMAKE_AUTOMOC ON)
        set(CMAKE_AUTORCC ON)
        set(CMAKE_AUTOUIC ON)
        set(CMAKE_AUTOSRC ON)
    endif()
else()
    message(WARNING "Qt${QT_VERSION_MAJOR} not found, project will be CLI only")
endif()

set(SRCS
    source/main.cpp
	)
	
set(HEADERS
    )

qt_add_executable(my_small_app
    ${SRCS} ${HEADERS}
)

qt_add_qml_module(my_small_app
    URI bensuperpc
    OUTPUT_DIRECTORY bensuperpc
    RESOURCE_PREFIX /bensuperpc.org
    VERSION 1.0
    QML_FILES
    qml/main.qml
    IMPORT_PATH qml
    RESOURCES
)

target_compile_features(my_small_app PUBLIC cxx_std_17)

set_property(TARGET my_small_app PROPERTY OUTPUT_NAME my_small_app)

# Qt${QT_VERSION_MAJOR}::LinguistTools
target_link_libraries(my_small_app
        PRIVATE Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2 Qt${QT_VERSION_MAJOR}::Widgets 
        Qt${QT_VERSION_MAJOR}::Charts Qt${QT_VERSION_MAJOR}::Concurrent Qt${QT_VERSION_MAJOR}::SerialPort 
        Qt${QT_VERSION_MAJOR}::VirtualKeyboard Qt${QT_VERSION_MAJOR}::Test Qt${QT_VERSION_MAJOR}::Network 
        Qt${QT_VERSION_MAJOR}::Sql Qt${QT_VERSION_MAJOR}::Xml Qt${QT_VERSION_MAJOR}::OpenGL Qt${QT_VERSION_MAJOR}::Sensors 
        Qt${QT_VERSION_MAJOR}::Bluetooth Qt${QT_VERSION_MAJOR}::DBus Qt${QT_VERSION_MAJOR}::Graphs
        Qt${QT_VERSION_MAJOR}::Quick3D Qt${QT_VERSION_MAJOR}::Positioning Qt${QT_VERSION_MAJOR}::Mqtt
        Qt${QT_VERSION_MAJOR}::Coap Qt${QT_VERSION_MAJOR}::NetworkAuth Qt${QT_VERSION_MAJOR}::RemoteObjects
        Qt${QT_VERSION_MAJOR}::TextToSpeech Qt${QT_VERSION_MAJOR}::WebSockets Qt${QT_VERSION_MAJOR}::Svg
        Qt${QT_VERSION_MAJOR}::Location Qt${QT_VERSION_MAJOR}::Nfc Qt${QT_VERSION_MAJOR}::SerialBus
        Qt${QT_VERSION_MAJOR}::WebChannel
        )