cmake_minimum_required(VERSION 3.16)

project(SainoHelicopter VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
find_package(Qt6 COMPONENTS ShaderTools)

qt_standard_project_setup(REQUIRES 6.5)

set(CMAKE_AUTORCC ON)


qt_add_executable(appSainoHelicopter
    vectors.qrc
    icon.qrc
    fonts.qrc
    main.cpp
)

qt_add_qml_module(appSainoHelicopter
    URI SainoHelicopter
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES HelicopterView.qml
    QML_FILES Helicopter.qml
    RESOURCES assets/rotor.png assets/top-down.png
    QML_FILES TumblerSelector.qml
    RESOURCES assets/battery.png assets/camera.png assets/cockpit.png assets/control-panel.png assets/fuel.png assets/lamps.png assets/radio.png assets/rotor.png assets/top-down.png
    QML_FILES HelicopterTopDown.qml
    QML_FILES LinearIndicator.qml
    RESOURCES fonts.qrc
    QML_FILES ListIndicator.qml
    QML_FILES TextDisplay.qml
    QML_FILES ControlPanel.qml
    RESOURCES icon.qrc
    RESOURCES vectors.qrc
)


# qt6_add_shaders(appSainoHelicopter "HelicopterShaders"
#     PREFIX
#         "/"
#     FILES
#         "shaders/wireframe.frag"
#         "shaders/wireframe.vert"
# )






# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSainoHelicopter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSainoHelicopter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSainoHelicopter
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appSainoHelicopter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
