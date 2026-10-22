/*
    SPDX-FileCopyrightText: 2024 macOS Desktop Plasma contributors
    SPDX-License-Identifier: GPL-2.0-or-later
*/
pragma ComponentBehavior: Bound

import QtQuick
import QtQml

import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    id: root

    required property int modelIndex
    required property var folderModel
    property string labelText: ""
    property var iconSource: null
    property int iconPixels: 64
    property bool locked: false
    property var folderView: null

    width: iconPixels + 12
    height: iconPixels + 28

    property bool selected: false

    // track selection from model? keep simple
    Connections {
        target: folderModel
        function onSelectionChanged() { }
    }

    Image {
        id: icon
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: iconPixels
        height: iconPixels
        source: root.iconSource
        asynchronous: true
        sourceSize.width: iconPixels
        sourceSize.height: iconPixels
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Text {
        id: label
        anchors.top: icon.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        text: root.labelText
        elide: Text.ElideMiddle
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Math.max(10, Kirigami.Units.smallSpacing * 3)
        color: "white"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: root.locked ? null : root
        drag.axis: Drag.XAndYAxis
        hoverEnabled: true
        cursorShape: root.locked ? Qt.ArrowCursor : Qt.OpenHandCursor

        onPressed: mouseEvent => {
            if (mouseEvent.button === Qt.RightButton) {
                root.folderModel.openContextMenu(root, mouseEvent.modifiers);
                mouseEvent.accepted = true;
                return;
            }
            // selection
            if (mouseEvent.modifiers & Qt.ControlModifier) {
                root.folderModel.toggleSelected(root.modelIndex);
            } else if (mouseEvent.modifiers & Qt.ShiftModifier) {
                // best-effort: select
                root.folderModel.setSelected(root.modelIndex);
            } else {
                root.folderModel.clearSelection();
                root.folderModel.setSelected(root.modelIndex);
            }
            root.selected = root.folderModel.isSelected(root.modelIndex);
        }

        onClicked: mouseEvent => {
            if (mouseEvent.button !== Qt.LeftButton) return;
            if (Application.styleHints.singleClickActivation) {
                root.folderModel.run(root.modelIndex);
            }
        }

        onDoubleClicked: mouseEvent => {
            if (mouseEvent.button !== Qt.LeftButton) return;
            if (!Application.styleHints.singleClickActivation) {
                root.folderModel.run(root.modelIndex);
            }
        }

        onReleased: mouseEvent => {
            if (!root.locked && root.folderView) {
                root.folderView.updatePosition(root.modelIndex, root.x, root.y);
            }
        }
    }
}
