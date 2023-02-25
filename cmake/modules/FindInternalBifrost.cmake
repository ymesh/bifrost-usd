
# Adds the private Bifrost SDK
function(bifrost_internal_sdk_init)

    set(amino_sdk_version_major 2)
    set(amino_sdk_version_minor 1)
    set(amino_sdk_version_patch 0)

    set(CMAKE_FIND_LIBRARY_PREFIXES "")
    set(CMAKE_FIND_LIBRARY_SUFFIXES "" )

    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
        set(CMAKE_FIND_LIBRARY_PREFIXES "")
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" )
    elseif( CMAKE_SYSTEM_NAME STREQUAL "Linux")
        set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
    elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
        set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dylib")
    endif()

    set(LIB_HINTS "${BIFROST_LOCATION}/lib")

    # Amino
    find_path(AminoSDK_INCLUDE_DIR
        NAMES
            AminoType.h
        HINTS
            ${BIFROST_LOCATION}/sdk/include/Amino
    )

    find_library(AminoSDK_LIBRARY
        NAMES AminoSDK_${amino_sdk_version_major}_${amino_sdk_version_minor}_${amino_sdk_version_patch}
        HINTS ${LIB_HINTS}
        NO_DEFAULT_PATH
    )

    # Geometry
    find_path(Geometry_INCLUDE_DIR
        NAMES
            bifrost_geometry.h
        HINTS
            ${BIFROST_LOCATION}/sdk/include/geometry
    )

    find_library(Geometry_LIBRARY
        NAMES Geometry_${amino_sdk_version_major}_${amino_sdk_version_minor}_${amino_sdk_version_patch}
        HINTS ${LIB_HINTS}
        NO_DEFAULT_PATH
    )

    # BIFObject
    find_path(BIFObject_INCLUDE_DIR
        NAMES
            bifrost_what_is.h
        HINTS
            ${BIFROST_LOCATION}/sdk/include/bifrost_object
    )

    find_library(BIFObject_LIBRARY
        NAMES BIFObject_${amino_sdk_version_major}_${amino_sdk_version_minor}_${amino_sdk_version_patch}
        HINTS ${LIB_HINTS}
        NO_DEFAULT_PATH
    )

    # Find all the necessary libs and files
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(InternalBifrost
        FOUND_VAR InternalBifrost_FOUND
        REQUIRED_VARS
            AminoSDK_INCLUDE_DIR
            AminoSDK_LIBRARY
            Geometry_INCLUDE_DIR
            Geometry_LIBRARY
            BIFObject_INCLUDE_DIR
            BIFObject_LIBRARY
        VERSION_VAR Bifrost_VERSION
    )

    # Define the targets...
    if(InternalBifrost_FOUND AND NOT TARGET InternalBifrost::InternalBifrost)  
        add_library(InternalBifrost::AminoSDK UNKNOWN IMPORTED)
        set_target_properties(InternalBifrost::AminoSDK PROPERTIES
            IMPORTED_LOCATION "${AminoSDK_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${AminoSDK_INCLUDE_DIR}"
        )

        add_library(InternalBifrost::Geometry UNKNOWN IMPORTED)
        set_target_properties(InternalBifrost::Geometry PROPERTIES
            IMPORTED_LOCATION "${Geometry_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${Geometry_INCLUDE_DIR}"
        )

        add_library(InternalBifrost::BIFObject UNKNOWN IMPORTED)
        set_target_properties(InternalBifrost::BIFObject PROPERTIES
            IMPORTED_LOCATION "${BIFObject_LIBRARY}"
            INTERFACE_INCLUDE_DIRECTORIES "${BIFObject_INCLUDE_DIR}"
        )

    endif()
endfunction()

# Using a function to scope variables and avoid polluting the global namespace!
bifrost_internal_sdk_init()
