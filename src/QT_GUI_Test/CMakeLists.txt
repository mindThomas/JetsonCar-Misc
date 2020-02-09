message(STATUS "   " ${CMAKE_CURRENT_SOURCE_DIR} "\t\t[${CMAKE_BUILD_TYPE}]")

# Edit the configuration line below to match binary needs
set(binary_dependencies
        ${Eigen3_LIBRARIES}
        ${Boost_LIBRARIES}
        Qt5::Core
        Qt5::Widgets
        Qt5::Network
        Qt5::PrintSupport
) # ${OpenCV_LIBRARIES}

# Configure build as release (for maximum optimization) 
set(CMAKE_BUILD_TYPE "Release")

update_folder_name() # Name the binary in this folder as the folder name
#message(STATUS "Source project: ${folder_name}")

FILE(GLOB_RECURSE binary_sources *.cpp) # find all cpp files
FILE(GLOB_RECURSE binary_headers *.hpp) # find all hpp files

FILE(GLOB_RECURSE ui_files *.ui) # find all ui files
FILE(GLOB_RECURSE qr_resources *.qrc) # find all qrc files

set(GLOBAL_HEADERS ${GLOBAL_HEADERS} ${binary_headers} ${general_headers} PARENT_SCOPE)

add_executable( ${folder_name} ${binary_sources} ${binary_headers} ${ui_files} ${qr_resources} ${GLOBAL_HEADERS} )
target_link_libraries( ${folder_name} ${binary_dependencies} )

set_target_properties( ${folder_name} PROPERTIES COMPILE_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -Wextra" ) # enable debugging

