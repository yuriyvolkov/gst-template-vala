project(plugin)
configure_file ("plugdef.in" "${CMAKE_CURRENT_BINARY_DIR}/plugdef.c")

include_directories(SYSTEM ${GLIB_INCLUDE_DIRS}
    ${GLIBCONFIG_INCLUDE_DIR}
    ${GSTREAMER_INCLUDE_DIRS})

set(COMMON_LIBS ${GLIB_LIBRARIES}
    ${GLIB_GOBJECT_LIBRARIES}
    ${GSTREAMER_LIBRARIES}
    ${GSTREAMER_BASE_LIBRARIES}
    )

set (SRC_LIST plugin.vala)

vala_precompile(PRECOMPILED_SRC_LIST ${SRC_LIST}
    DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
    CUSTOM_VAPIS
    vapi/gstreamer-1.0.vapi
    GENERATE_HEADER
    plugin
    )

set(PRECOMPILED_SRC_LIST ${PRECOMPILED_SRC_LIST} plugdef.c)

add_library(${PROJECT_NAME} SHARED ${PLUGIN_BUILD_TYPE} ${PRECOMPILED_SRC_LIST})
target_link_libraries(${PROJECT_NAME} ${COMMON_LIBS})

