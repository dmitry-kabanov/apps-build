prepare() {
    rm -rf $package_build_dir
    tar -xzf $APPS_SOURCE_DIR/$package-$version.tar.gz -C $APPS_BUILD_DIR
    mv $APPS_BUILD_DIR/$package-$version $package_build_dir
    cd $package_build_dir
}

configure() {
    echo "Configuring... Prefix is $package_install_dir"
    echo -e "./configure\n$configure_opts\nCFLAGS=$CFLAGS\n" > configure.out 

    if [ -z "$1" ] ; then
        ./configure $configure_opts CFLAGS=$CFLAGS 2>&1 >> configure.out
    else    
        CFLAGS=$CFLAGS ./configure $configure_opts 2>&1 >> configure.out
    fi

    echo "Configure is done. See $package_build_dir/configure.out"
}

compile() {
    echo "Compiling..."
    make 2>&1 > make.out 
    if [ $? != 0 ]; then
        echo "There was an error during make. See file $package_build_dir/make.out"
    else
        echo "make was successful. See file $package_build_dir/make.out"
    fi
}

test() {
    make check 2>&1 > make-check.out
    if [ $? != 0 ]; then
        echo "There was an error during make check. See file $package_build_dir/make-check.out"
    else
        echo "make check was successful. See file $package_build_dir/make-check.out"
    fi
}

install() {
    sudo rm -rf $package_install_dir 
    sudo mkdir -p $package_install_dir  
    sudo make install 2>&1 > make-install.out
    if [ $? != 0 ]; then
        echo "There was an error during make install See file $package_build_dir/make-install.out"
    else
        echo ""Built and installed successfully.". See file $package_build_dir/make-install.out"
    fi
}

postinstall() {
    sudo cp $package_build_dir/configure.out $package_install_dir
    sudo cp $package_build_dir/make.out $package_install_dir
    sudo cp $package_build_dir/make-check.out $package_install_dir
    sudo cp $package_build_dir/make-install.out $package_install_dir
}
