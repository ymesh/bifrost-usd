//-
// Copyright 2022 Autodesk, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//+

#ifndef BIFROST_HD_TEST_SCENE_INDEX_PRIM_H
#define BIFROST_HD_TEST_SCENE_INDEX_PRIM_H

#include <gtest/gtest.h>

#include "RecordingSceneIndexObserver.h"

#include <pxr/imaging/hd/sceneIndex.h>
#include <pxr/usd/usd/stage.h>
#include <pxr/usd/usdGeom/tokens.h>
#include <pxr/usdImaging/usdImaging/tokens.h>
#include <pxr/usdImaging/usdImagingGL/engine.h>

using UsdImagingGLEngineSharedPtr =
    std::shared_ptr<class pxr::UsdImagingGLEngine>;

namespace BifrostHdTest {

class TestSceneIndexPrim : public ::testing::Test {
protected:
    pxr::UsdStageRefPtr openStage(const std::string& stageFilePath);

    bool render();

    void reRender();

    pxr::HdSceneIndexPrim getHdPrim(const pxr::SdfPath& bifrostProcPrimPath);

    static void ExportAsString(const pxr::HdSceneIndexPrim& prim,
                               const std::string&           filePath = "");

    static void TestHdSceneIndexMesh(const pxr::HdSceneIndexPrim& prim,
                                     bool hasDisplayColor = true);

    static void TestHdSceneIndexBasisCurves(const pxr::HdSceneIndexPrim& prim);

    pxr::UsdStageRefPtr         stage;
    UsdImagingGLEngineSharedPtr engine;
    pxr::HdSceneIndexBaseRefPtr sceneIndex;
    RecordingSceneIndexObserver observer;

private:
};

} // namespace BifrostHdTest

#endif // BIFROST_HD_TEST_SCENE_INDEX_PRIM_H
