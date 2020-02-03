# check the existance of GTSAM, if not/outdated, install/reinstall
find_package(GTSAM) # REQUIRED
if (${GTSAM_FOUND})
	message(STATUS "GTSAM found")
else()
	message(STATUS "GTSAM not found! Executing install script.")
	execute_process(COMMAND ${CMAKE_CURRENT_LIST_DIR}/install.sh
	    		RESULT_VARIABLE retcode)
	if(NOT ${retcode} EQUAL 0)
	    message(FATAL_ERROR "gtsam.cmake: Error when excuting ${CMAKE_CURRENT_LIST_DIR}/install.sh")
	endif()
	find_package(GTSAM REQUIRED) # try and find again
endif()
include_directories(${GTSAM_INCLUDE_DIR})


#set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} $ENV{NUCORE}/build/gtsam/lib/cmake/GTSAM)
#find_package(GTSAM REQUIRED)
#include_directories(SYSTEM "$ENV{NUCORE}/build/gtsam/include")
#link_directories($ENV{NUCORE}/build/gtsam/lib)

#mark_as_advanced(
#    EIGEN_INCLUDE_DIRS
#    GTSAM_DIR
#    GTSAM_INCLUDE_DIR
#)
