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

#ifndef BIFROST_HD_GRAPH_GEOMETRY_H
#define BIFROST_HD_GRAPH_GEOMETRY_H

#include <Bifrost/Object/Object.h>

#include <pxr/base/tf/denseHashMap.h>
#include <pxr/imaging/hd/sceneIndex.h>
#include <pxr/imaging/hd/dataSource.h>

#include <unordered_map>

namespace BifrostHd {

using ChildPrimMap = pxr::TfDenseHashMap<pxr::SdfPath, pxr::HdSceneIndexPrim, pxr::TfHash>;

class Geometry {
public:
    explicit Geometry();

    virtual ~Geometry();

    virtual const pxr::TfToken& getSceneIndexPrimTypeName() const = 0;

    virtual const pxr::HdDataSourceLocator& TopologyLocator() const = 0;

    virtual const ChildPrimMap& getChildren() const = 0;

public:
    /// Disabled
    /// \{
    Geometry(Geometry const&)             = delete;
    Geometry(Geometry&&)                  = delete;
    Geometry& operator=(const Geometry&)  = delete;
    Geometry& operator=(Geometry&&) = delete;
    /// \}

protected:
    ChildPrimMap m_children_map;  
};

} // namespace BifrostHd

#endif // BIFROST_HD_GRAPH_GEOMETRY_H
