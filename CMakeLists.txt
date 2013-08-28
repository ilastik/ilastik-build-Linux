CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

project(ilastik)

set (BUILDEM_DIR "None" CACHE TYPE STRING)

if (${BUILDEM_DIR} STREQUAL "None")
    message (FATAL_ERROR "ERROR: FlyEM build directory (for all downloads & builds) should be specified via -D BUILDEM_DIR=<path> on cmake command line.")
endif ()

get_filename_component(BUILDEM_REPO_DIR ../buildem ABSOLUTE)
if (NOT EXISTS ${BUILDEM_REPO_DIR}/python.cmake)
    message ("Downloading buildem repository ...")
    execute_process(COMMAND git clone https://github.com/janelia-flyem/buildem.git ${BUILDEM_REPO_DIR}
                    WORKING_DIRECTORY ${BUILDEM_DIR}
                    RESULT_VARIABLE BUILDEM_INSTALL_FAILED)
    if(BUILDEM_INSTALL_FAILED)
        MESSAGE(FATAL_ERROR "Unable to clone buildem scripts from\n     'https://github.com/janelia-flyem/buildem.git'\n(either git is not installed properly on your system, or the repository is not accessible). Please place buildem at\n    '${BUILDEM_REPO_DIR}'.")
    endif()
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${BUILDEM_REPO_DIR})

include(ilastik-gui)

#install(CODE "execute_process(COMMAND ${PYTHON_EXE} ${PROJECT_SOURCE_DIR}/compile_all.py ${BUILDEM_DIR}/ilastik)")

INSTALL(DIRECTORY ${ilastik_SRC_DIR}/ DESTINATION src/${ilastik_NAME} USE_SOURCE_PERMISSIONS)
INSTALL(DIRECTORY ${BUILDEM_DIR}/bin/ DESTINATION bin USE_SOURCE_PERMISSIONS)
INSTALL(DIRECTORY ${BUILDEM_DIR}/lib/ DESTINATION lib USE_SOURCE_PERMISSIONS)
INSTALL(DIRECTORY ${BUILDEM_DIR}/include/ DESTINATION include USE_SOURCE_PERMISSIONS)
INSTALL(DIRECTORY ${BUILDEM_DIR}/plugins/ DESTINATION plugins USE_SOURCE_PERMISSIONS)

SET(CPACK_PACKAGE_VENDOR "The ilastik Team")
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY
    "Interactive image labeling and segmentation toolkit."
)

# package version setup
SET(CPACK_PACKAGE_VERSION_MAJOR "0")
SET(CPACK_PACKAGE_VERSION_MINOR "6")
SET(CPACK_PACKAGE_VERSION_PATCH "a")

SET(CPACK_PACKAGE_INSTALL_DIRECTORY     "${PROJECT_NAME}-0.6.a")
SET(CPACK_STRIP_FILES TRUE)
SET(CPACK_PACKAGE_CONTACT "ilastik Team <team@ilastik.org>")
SET(CPACK_GENERATOR TGZ)

INCLUDE (CPack)
