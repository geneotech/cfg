cmake_minimum_required(VERSION 3.2)

project(onecpp)
message("Building onecpp.")
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/extra-cmake-modules/find-modules")
set(CMAKE_CXX_FLAGS
	"${CMAKE_CXX_FLAGS} -std=gnu++1z"
)

	if(${ARCHITECTURE} STREQUAL "x64")
		set(HYPERSOMNIA_CXX_FLAGS "${HYPERSOMNIA_CXX_FLAGS} -m64")
		set(HYPERSOMNIA_C_FLAGS "${HYPERSOMNIA_C_FLAGS} -m64")
	endif()

add_executable(onecpp 
	"one.cpp"
)

	message("OPENGL_INCLUDE_DIRS before finding: ${OPENGL_INCLUDE_DIRS}")
	message("OPENGL_LIBRARIES before finding: ${OPENGL_LIBRARIES}")
	find_package(OpenGL REQUIRED)
	message("OPENGL_INCLUDE_DIRS after finding: ${OPENGL_INCLUDE_DIRS}")
	message("OPENGL_LIBRARIES after finding: ${OPENGL_LIBRARIES}")

	include_directories(${OPENGL_INCLUDE_DIRS})

target_link_libraries(onecpp stdc++fs)
target_link_libraries(onecpp ${OPENGL_LIBRARIES})

find_package(X11 REQUIRED)
include_directories(${X11_INCLUDE_DIR})
target_link_libraries(onecpp ${X11_LIBRARIES})
#target_link_libraries(onecpp xcb)

find_package(XCB REQUIRED)
include_directories(${XCB_INCLUDE_DIR})
target_link_libraries(onecpp ${XCB_LIBRARIES})

find_package(X11_XCB REQUIRED)
include_directories(${X11_XCB_INCLUDE_DIR})
target_link_libraries(onecpp ${X11_XCB_LIBRARIES})

add_custom_target(run
	COMMAND onecpp
	DEPENDS onecpp
	WORKING_DIRECTORY ${ONECPP_SOURCE_DIR} 
)

add_custom_target(debug
	COMMAND cgdb $<TARGET_FILE:onecpp>
	DEPENDS onecpp
	WORKING_DIRECTORY ${ONECPP_SOURCE_DIR} 
)

