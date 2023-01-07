#-
#*****************************************************************************
# Copyright 2022 Autodesk, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#*****************************************************************************
#+

add_subdirectory(testUtils)

#------------------------------------------------------------------------------
# Library dependencies
#------------------------------------------------------------------------------

set(libs
    Amino::Core
    InternalBifrost::AminoSDK
    InternalBifrost::Geometry
    InternalBifrost::BIFObject
    BifrostGraph::Executor
    BifrostHdTranslators
    BifrostHdEngine
    BifrostUSDTestUtils
    BifrostHdTestUtils
    bifusd_gtest
)

set(pxr_libs
    arch
    garch
    glf
    hd
    sdf
    tf
    usd
    usdUtils
    usdImaging
    usdImagingGL

)

#------------------------------------------------------------------------------
# test files
#------------------------------------------------------------------------------
set(test_files
    testHdSceneIndexBifrostGraphPrim.cpp
    testHdSceneIndexQueries.cpp
)

set(bifrost_env_config
    BIFROST_LOCATION=${BIFROST_LOCATION}
    BIFROST_LIB_CONFIG_FILES=${CMAKE_INSTALL_PREFIX}/bifrost_hydra_translation.json:${PROJECT_SOURCE_DIR}/test/BifrostHydra/content_config.json
)

set(usd_env_config
     USD_TEST_RESOURCES_DIR=${CMAKE_CURRENT_SOURCE_DIR}/resources
     PXR_AR_DEFAULT_SEARCH_PATH=${resources_dir}
     PXR_PLUGINPATH_NAME=${CMAKE_INSTALL_PREFIX}/${BIFUSD_INSTALL_COMMON_DIR}/plugin/procedural/resources
     HD_ENABLE_SCENE_INDEX_EMULATION=1
     USDIMAGINGGL_ENGINE_ENABLE_SCENE_INDEX=1
     HDGP_INCLUDE_DEFAULT_RESOLVER=1
     USD_TEST_OUTPUT_DIR=${CMAKE_CURRENT_BINARY_DIR}
)

foreach(test_file ${test_files})
    configure_bifusd_unittest(
        ${test_file} "bifrost_hydra"
        LINK_LIBS ${libs} ${pxr_libs}
        SHARED_LIB_DIRS ${BIFUSD_EXTRA_BUILD_AND_TEST_PATHS}
        ENV_VARS ${bifrost_env_config} ${usd_env_config}
        ASAN_OPTIONS ${ASAN_OPTIONS}
        OPTIONS      $<${BIFUSD_IS_MSC}:/wd4251 /wd4273>
    )
endforeach()
