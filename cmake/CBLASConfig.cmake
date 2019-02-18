if(NOT ${CBLAS_DEFINES} STREQUAL "")
    message('cblas defines: ' ${CBLAS_DEFINES})
    return()
endif()

string(ASCII 27 Esc)
set(Red         "${Esc}[31m")
set(Blue        "${Esc}[34m")
set(ColourReset "${Esc}[m")

message(STATUS "Checking for CBLAS...")

#message("blas_links: " ${BLAS_links})
#message("blas_defines: " ${BLAS_DEFINES})
#message("lib_defines: " ${LIB_DEFINES})
#message("blas_cxx_flags: " ${BLAS_cxx_flags})
#message("blas_int: " ${BLAS_int})

if(NOT "${BLAS_DEFINES}" STREQUAL "")
    set(local_BLAS_DEFINES "-D${BLAS_DEFINES}")
else()
    set(local_BLAS_DEFINES "")
endif()
if(NOT "${LIB_DEFINES}" STREQUAL "")
    set(local_LIB_DEFINES "-D${LIB_DEFINES}")
else()
    set(local_LIB_DEFINES "")
endif()
#message("local_LIB_DEFINES: " ${local_LIB_DEFINES})
#message("local_BLAS_DEFINES: " ${local_BLAS_DEFINES})

set(run_output1 "")
set(compile_OUTPUT1 "")

try_run(run_res1 compile_res1 ${CMAKE_CURRENT_BINARY_DIR}
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/config/cblas.cc
    LINK_LIBRARIES
        ${BLAS_cxx_flags}
        ${BLAS_links}
    COMPILE_DEFINITIONS
        ${local_BLAS_DEFINES}
        ${local_LIB_DEFINES}
        ${BLAS_int}
    COMPILE_OUTPUT_VARIABLE
        compile_OUTPUT1
    RUN_OUTPUT_VARIABLE
        run_output1
    )

#message ('compile output: ' ${compile_OUTPUT1})
#message ('run output: ' ${run_output1})

if (compile_res1 AND NOT ${run_res1} MATCHES "FAILED_TO_RUN")
    message("${Blue}  Found CBLAS${ColourReset}")
    set(CBLAS_DEFINES "HAVE_CBLAS" CACHE INTERNAL "")
else()
    message("${Red}  CBLAS not found.${ColourReset}")
    set(CBLAS_DEFINES "" CACHE INTERNAL "")
endif()

set(run_output1 "")
set(compile_OUTPUT1 "")

#message("cblas defines: " ${CBLAS_DEFINES})