if [ $# -lt 1 ] ; then
    echo "Usage: sh <script-name> <compiler-name>"
    exit
fi

comp_fam_ver=$1

if [ $comp_fam_ver == intel-2013u4 ] ; then
    comp_fam=intel
    comp_ver=2013u4
fi
