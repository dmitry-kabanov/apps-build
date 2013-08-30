package=openmpi
version=1.6.5

source ~/.apps.conf
source ~/.apps-compiler.sh $1
source ~/.apps-functions.sh

package_build_dir=$APPS_BUILD_DIR/$package-$version-$comp_fam_ver
package_install_dir=$APPS_INSTALL_ROOT_DIR/$comp_fam_ver/$package/$version

prepare "bzip"

configure_opts=$(cat <<EOF
--prefix=$package_install_dir
EOF
)

configure 
compile
test
install
postinstall

package_modulefile_dir=$comp_fam/$comp_ver/$package
package_modulefile_install_dir=$APPS_MODULEFILES_INSTALL_DIR/Compiler/$package_modulefile_dir
package_modulefile_source=$APPS_MODULEFILES_SOURCE_DIR/Compiler/$package.lua
sudo mkdir -p $package_modulefile_install_dir
sudo cp $package_modulefile_source $package_modulefile_install_dir/$version.lua
