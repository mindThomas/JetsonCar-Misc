set(QT_PATH /home/thomas/.conan/data/Qt/5.12.3/av/2019-06-11-4f82368/package/e8a30189a39d077f20a05816247db432cae647ac/lib)
#set(QT_PATH /usr/lib/x86_64-linux-gnu)
set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${QT_PATH})
find_package(Qt5Concurrent REQUIRED PATHS ${QT_PATH})
find_package(Qt5Widgets REQUIRED PATHS ${QT_PATH})
find_package(Qt5OpenGL REQUIRED PATHS ${QT_PATH})
find_package(Qt5Test REQUIRED PATHS ${QT_PATH})
#find_package(Qt5X11Extras REQUIRED PATHS ${QT_PATH})
#find_package(Qt5MultimediaWidgets REQUIRED PATHS ${QT_PATH})
include_directories(SYSTEM ${Qt5Widgets_INCLUDE_DIRS} ${Qt5OpenGL_INCLUDE_DIRS} )

mark_as_advanced(
    Qt5Core_DIR
    Qt5Gui_DIR
    Qt5MultimediaWidgets_DIR
    Qt5Multimedia_DIR
    Qt5Network_DIR
    Qt5OpenGL_DIR
    Qt5Positioning_DIR
    Qt5Qml_DIR
    Qt5Quick_DIR
    Qt5WebChannel_DIR
    #Qt5Widgets_DIR
    #Qt5X11Extras_DIR
    Qt5_DIR
)
