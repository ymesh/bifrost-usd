#
# Config <bifrost-usd>
#
app_name='bifrost-usd'

USD_VER="23.08"
RMAN_VER="25.2"
MAYA_VER="2024"
BIFROST_VER="2.7.1.0"
#MAYA_MINOR_VER="3"
DEVKIT_VER="2024.1"
MAYA_PYTHON_VERSION="310"
MAYA_LOCATION="/usr/autodesk/maya${MAYA_VER}"

source ../../env_py${MAYA_PYTHON_VERSION}/bin/activate

cur_dir=`pwd`
tmp_dir="tmp_${app_name}"

NINJA="/home/data/code/me/env_py310/lib/python3.10/site-packages/ninja/data/bin/ninja"

deploy_root="/home/data/tools"
deploy_dir="${deploy_root}/USD/autodesk/${app_name}_${MAYA_VER}"
#

mkdir -p $tmp_dir
# pushd $tmp_dir

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

export BIFUSD_PACKAGE_NAME="ymesh_usd_pack"
export BIFROST_LOCATION="/usr/autodesk/bifrost/maya${MAYA_VER}/${BIFROST_VER}/bifrost"
export USD_LOCATION="${deploy_root}/USD/pixar/USD-v${USD_VER}"
export MaterialX_DIR="${deploy_root}/MaterialX/MaterialX-v1.38.7"

# cmake3 -L -G "Unix Makefiles" \
# -DCMAKE_BUILD_TYPE="Release" \
# -DCMAKE_INSTALL_PREFIX=${deploy_dir} \
# ../src

cmake3 -G Ninja -S ./.. -B ${tmp_dir} -Wno-dev \
  -DCMAKE_MAKE_PROGRAM=${NINJA} \
  -DBIFUSD_PACKAGE_NAME=${BIFUSD_PACKAGE_NAME} \
  -DCMAKE_BUILD_TYPE="Release" \
  -DCMAKE_INSTALL_PREFIX=${deploy_dir} \
  -DBIFROST_LOCATION=${BIFROST_LOCATION} \
  -DUSD_LOCATION=${USD_LOCATION} \
  -DMAYA_RUNTIME_LOCATION=${MAYA_LOCATION} \
  -DMaterialX_DIR=${MaterialX_DIR}

# popd

if [ $? -eq 0 ]
then
  echo "* "
  echo "* cmake config completed." 
  echo "* executing: \"cmake --build ${tmp_dir} --target install\" " 
  echo "* "
else
  echo "* "
  echo "* cmake config error!"
  echo "* "
fi

