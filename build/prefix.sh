export PATH=/home/raihan/.local/bin:$PATH

# LD_LIBRARY_PATH only needed if you are building without rpath
# export LD_LIBRARY_PATH=/home/raihan/.local/lib:$LD_LIBRARY_PATH

export XDG_DATA_DIRS=/home/raihan/.local/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
export XDG_CONFIG_DIRS=/home/raihan/.local/etc/xdg:${XDG_CONFIG_DIRS:-/etc/xdg}

export QT_PLUGIN_PATH=/home/raihan/.local/lib/plugins:$QT_PLUGIN_PATH
export QML2_IMPORT_PATH=/home/raihan/.local/lib/qml:$QML2_IMPORT_PATH

export QT_QUICK_CONTROLS_STYLE_PATH=/home/raihan/.local/lib/qml/QtQuick/Controls.2/:$QT_QUICK_CONTROLS_STYLE_PATH

export MANPATH=/home/raihan/.local/share/man:${MANPATH:-/usr/local/share/man:/usr/share/man}

export SASL_PATH=/home/raihan/.local/lib/sasl2:${SASL_PATH:-/usr/lib/sasl2}

export PYTHONPATH="/home/raihan/.local/lib/python3.14/site-packages":$PYTHONPATH
