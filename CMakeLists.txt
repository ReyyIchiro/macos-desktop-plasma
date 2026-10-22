cmake_minimum_required(VERSION 3.27)

project(macos-desktop-plasma)

set(QT_MIN_VERSION "6.4.0")
set(KF6_MIN_VERSION "6.0.0")

find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

find_package(Qt6 ${QT_MIN_VERSION} REQUIRED COMPONENTS Core Qml)
find_package(KF6 ${KF6_MIN_VERSION} REQUIRED COMPONENTS I18n)
find_package(Plasma ${KF6_MIN_VERSION} REQUIRED)

plasma_install_package(plasmoid org.kde.plasma.macosdesktop)
