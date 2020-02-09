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


#set(WRAP_CPP_FILES testview.h)
#set(WRAP_UI_FILES testview.ui)
#set(QT_LIBRARIES Core Gui PrintSupport Network)
#
#
#set(GLOBAL_HEADERS ${GLOBAL_HEADERS} ${binary_headers} ${general_headers} PARENT_SCOPE)
#
##add_executable( ${folder_name} ${binary_sources} ${binary_headers} ${GLOBAL_HEADERS} )
##target_link_libraries( ${folder_name} ${binary_dependencies} )
#
#set(CMAKE_INCLUDE_CURRENT_DIR ON)
#
#
#if(${VTK_VERSION} VERSION_GREATER "6" AND VTK_QT_VERSION VERSION_GREATER "4")
#  qt5_wrap_ui(PROJECT_FORMS_HEADERS ${WRAP_UI_FILES} )
#  # CMAKE_AUTOMOC in ON so the MOC headers will be automatically wrapped.
#  add_executable(${folder_name}
#    ${binary_sources}
#    ${PROJECT_FORMS_HEADERS}
#    ${WRAP_CPP_FILES}
#    ${GLOBAL_HEADERS})
#  qt5_use_modules(${folder_name} ${QT_LIBRARIES})
#  target_link_libraries(${folder_name}
#      ${PCL_LIBRARIES}
#      ${VTK_LIBRARIES}
#      ${binary_dependencies})
#else()
#  QT4_WRAP_UI(PROJECT_FORMS_HEADERS ${WRAP_UI_FILES})
#  QT4_WRAP_CPP(PROJECT_HEADERS_MOC ${WRAP_CPP_FILES})
#  add_executable(${folder_name}
#      ${binary_sources}
#      ${PROJECT_FORMS_HEADERS}
#      ${PROJECT_HEADERS_MOC})
#
#  if(VTK_LIBRARIES)
#    if(${VTK_VERSION} VERSION_LESS "6")
#      target_link_libraries(${folder_name}
#          ${PCL_LIBRARIES}
#          ${VTK_LIBRARIES}
#          QVTK
#          ${binary_dependencies})
#    else()
#      target_link_libraries(${folder_name}
#          ${PCL_LIBRARIES}
#          ${VTK_LIBRARIES}
#          ${binary_dependencies})
#    endif()
#  else()
#    target_link_libraries(${folder_name}
#        vtkHybrid
#        QVTK
#        vtkViews
#        ${QT_LIBRARIES}
#        ${PCL_LIBRARIES}
#        ${binary_dependencies})
#  endif()
#endif()

set_target_properties( ${folder_name} PROPERTIES COMPILE_FLAGS "${CMAKE_CXX_FLAGS} -g -Wall -Wextra" ) # enable debugging

