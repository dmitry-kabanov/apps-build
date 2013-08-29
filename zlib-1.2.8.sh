package=zlib
version=1.2.8

source ~/.apps.conf
source ~/.apps-compiler.sh $1
source ~/.apps-functions.sh

package_build_dir=$APP_BUILD_DIR/$package-$version-$comp_fam_ver
package_install_dir=$APP_INSTALL_ROOT_DIR/$comp_fam_ver/$package/$version

prepare

configure_opts=$(cat <<EOF
--prefix=$package_install_dir
--64
EOF
)

if [[ $comp_fam_ver == intel* ]] ; then
    CFLAGS="-O3 -xHost -opt-prefetch"
fi

configure "cflags_first"
compile
test
install
postinstall

# Copy module file
