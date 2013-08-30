if [ $# -lt 1 ] ; then
    echo "Usage: sh <script-name> <compiler-name>"
    exit
fi

comp_fam_ver=$1

. $APPS_MODULEFILES_INSTALL_DIR/../lmod/lmod/init/profile
module purge

if [ $comp_fam_ver == intel-2013u4 ] ; then
    comp_fam=intel
    comp_ver=2013u4
fi

module load $comp_fam/$comp_ver
