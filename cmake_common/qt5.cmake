# See https://doc.qt.io/qt-5/cmake-get-started.html#build-a-gui-executable

# Enable auto-generation of GUI files
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
  set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

find_package(Qt5
      COMPONENTS
        Core
        Widgets
        Network
        PrintSupport
      REQUIRED)

#
#set(QT_PATH /usr/lib/x86_64-linux-gnu)
#set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${QT_PATH})
#find_package(Qt5Concurrent REQUIRED PATHS ${QT_PATH})
#find_package(Qt5Widgets REQUIRED PATHS ${QT_PATH})
#find_package(Qt5OpenGL REQUIRED PATHS ${QT_PATH})
#find_package(Qt5PrintSupport REQUIRED PATHS ${QT_PATH})
#find_package(Qt5Network REQUIRED PATHS ${QT_PATH})
#find_package(Qt5Test REQUIRED PATHS ${QT_PATH})
##find_package(Qt5X11Extras REQUIRED PATHS ${QT_PATH})
##find_package(Qt5MultimediaWidgets REQUIRED PATHS ${QT_PATH})
#include_directories(SYSTEM ${Qt5Widgets_INCLUDE_DIRS} ${Qt5OpenGL_INCLUDE_DIRS} )
#
#mark_as_advanced(
#    Qt5Core_DIR
#    Qt5Gui_DIR
#    Qt5MultimediaWidgets_DIR
#    Qt5Multimedia_DIR
#    Qt5Network_DIR
#    Qt5OpenGL_DIR
#    Qt5Positioning_DIR
#    Qt5Qml_DIR
#    Qt5Quick_DIR
#    Qt5WebChannel_DIR
#    Qt5PrintSupport_DIR
#    Qt5Network_DIR
#    Qt5Widgets_DIR
#    #Qt5X11Extras_DIR
#    Qt5_DIR
#)
#
## Find VTK
#find_package(VTK REQUIRED)
#include(${VTK_USE_FILE})
#
#message(STATUS "VTK_QT_VERSION: " ${VTK_QT_VERSION})
#if(${VTK_VERSION} VERSION_GREATER "6" AND VTK_QT_VERSION VERSION_GREATER "4")
#  message(STATUS "Using Qt5")
#  # Instruct CMake to run moc automatically when needed.
#  set(CMAKE_AUTOMOC ON)
#  find_package(Qt5Widgets REQUIRED QUIET)
#else()
#  message(STATUS "Using Qt4")
#  find_package(Qt4 COMPONENTS QtCore QtGui REQUIRED)
#  include(${QT_USE_FILE})
#endif()
