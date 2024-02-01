cmake_minimum_required(VERSION 3.14)

project(
    GTA_SA_cheat_finder
    VERSION 2.0.0
    DESCRIPTION ""
    HOMEPAGE_URL "https://github.com/bensuperpc"
    LANGUAGES C CXX
)

find_package(QT NAMES Qt6 COMPONENTS Quick QuickControls2 Gui Core Qml Charts Multimedia Widgets Concurrent SerialPort)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick QuickControls2 Gui Core Qml Charts Multimedia Widgets Concurrent SerialPort)

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

target_link_libraries(my_small_app
        PRIVATE Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2 Qt${QT_VERSION_MAJOR}::Widgets Qt${QT_VERSION_MAJOR}::Charts Qt${QT_VERSION_MAJOR}::Concurrent)
