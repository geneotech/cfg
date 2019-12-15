cmake_minimum_required(VERSION 2.8)
project( ocv )
set(CMAKE_CXX_FLAGS " -std=gnu++1z ")
add_executable( ocv main.cpp )

get_target_property(OUT ocv LINK_LIBRARIES)
target_link_libraries(ocv dl)
message("ALL:  ${OUT} rel: ${CMAKE_EXE_LINKER_FLAGS_RELEASE}")

message("All linker flags (after target_link_libraries): ${CMAKE_EXE_LINKER_FLAGS}")
