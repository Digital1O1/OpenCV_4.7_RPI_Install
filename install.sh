# remove old versions or previous builds
cd ~ 
sudo rm -rf opencv*
# download the latest version
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.7.0.zip 
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.7.0.zip 
# unpack
unzip opencv.zip 
unzip opencv_contrib.zip 
# some administration to make live easier later on
mv opencv-4.7.0 opencv
mv opencv_contrib-4.7.0 opencv_contrib
# clean up the zip files
rm opencv.zip
rm opencv_contrib.zip


# set install dir
cd ~/opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D ENABLE_NEON=ON \
-D ENABLE_VFPV3=ON \
-D WITH_OPENMP=ON \
-D WITH_OPENCL=OFF \
-D BUILD_ZLIB=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=OFF \
-D WITH_GSTREAMER=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_VTK=OFF \
-D WITH_QT=OFF \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_opencv_python3=ON \
-D PYTHON3_EXECUTABLE=$(which python3) \
-D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-D PYTHON3_LIBRARY=$(python3 -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
-D BUILD_EXAMPLES=OFF ..

make -j4
sudo make install
sudo ldconfig 
make clean
sudo apt-get update && sudo apt-get upgrade

cd ~
rm opencv.zip
rm opencv_contrib.zip
# sudo reboot
