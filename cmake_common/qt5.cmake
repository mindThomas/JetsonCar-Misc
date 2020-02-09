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