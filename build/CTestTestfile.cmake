# CMake generated Testfile for 
# Source directory: /home/raihan/Workspace/coders/macos-desktop-plasma
# Build directory: /home/raihan/Workspace/coders/macos-desktop-plasma/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test("appstreamtest" "/usr/sbin/cmake" "-DAPPSTREAMCLI=/usr/sbin/appstreamcli" "-DINSTALL_FILES=/home/raihan/Workspace/coders/macos-desktop-plasma/build/install_manifest.txt" "-P" "/usr/share/ECM/kde-modules/appstreamtest.cmake")
set_tests_properties("appstreamtest" PROPERTIES  _BACKTRACE_TRIPLES "/usr/share/ECM/kde-modules/KDECMakeSettings.cmake;177;add_test;/usr/share/ECM/kde-modules/KDECMakeSettings.cmake;195;appstreamtest;/usr/share/ECM/kde-modules/KDECMakeSettings.cmake;0;;/home/raihan/Workspace/coders/macos-desktop-plasma/CMakeLists.txt;12;include;/home/raihan/Workspace/coders/macos-desktop-plasma/CMakeLists.txt;0;")
