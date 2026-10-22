/*
    SPDX-FileCopyrightText: 2024 macOS Desktop Plasma contributors
    SPDX-License-Identifier: GPL-2.0-or-later
*/
pragma ComponentBehavior: Bound

import QtQuick
import QtQml

import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

import org.kde.private.desktopcontainment.folder as Folder

import "code/PositionStore.js" as PositionStore

FocusScope {
    id: main

    property Folder.FolderModel model: dir

    property alias url: dir.url
    property alias status: dir.status
    property alias errorString: dir.errorString
    property alias locked: dir.locked
    property alias sortMode: dir.sortMode
    property alias filterMode: dir.filterMode
    property alias filterPattern: dir.filterPattern
    property alias filterMimeTypes: dir.filterMimeTypes
    property alias showHiddenFiles: dir.showHiddenFiles
    property alias creatingNewItems: dir.creatingNewItems
    property alias dragging: dir.dragging
    property alias dragInProgressAnywhere: dir.dragInProgressAnywhere

    property bool isRootView: false
    property var positionerApplet: null
    property int iconSize: (Plasmoid.configuration.iconSize >= 0 ? Plasmoid.configuration.iconSize : 3)
    // iconSize in config is index; map to pixels roughly via Kirigami? Keep as config index for binding compat.
    // For rendering we need pixels; convert config index to pixels.
    readonly property int iconPixels: {
        const sizes = [22, 32, 48, 64, 96, 128, 256];
        const idx = (typeof Plasmoid.configuration.iconSize === "number") ? Plasmoid.configuration.iconSize : 3;
        return sizes[Math.max(0, Math.min(sizes.length - 1, idx))];
    }

    property int currentIndex: -1
    property var hoveredItem: null
    property bool containsMouse: false
    property bool overflowing: false
    property int cellWidth: iconPixels + 16
    property int cellHeight: iconPixels + 32
    property var view: canvas

    property int flow: GridView.FlowLeftToRight
    property int layoutDirection: Qt.LeftToRight

    signal sortModeChanged()

    function positionViewAtBeginning() { }
    function forceActiveFocus() { main.forceActiveFocus(); }
    function cancelRename() { }
    function linkHere(sourceUrl) { dir.linkHere(sourceUrl); }
    function drop(target, event, pos) { dir.drop(target, event, -1); }

    // Position store helpers
    function screenKey() { return Math.round(width) + "x" + Math.round(height); }

    function urlForIndex(idx) {
        try { return dir.urlForIndex(idx); } catch (e) { return ""; }
    }

    function defaultPos(idx) {
        const cols = Math.max(1, Math.floor((width || 800) / (iconPixels + 12)));
        const col = idx % cols;
        const row = Math.floor(idx / cols);
        return [col * (iconPixels + 12) + 4, row * (iconPixels + 36) + 4];
    }

    function storedPos(idx) {
        const key = screenKey();
        const url = urlForIndex(idx);
        let all = {};
        try { all = JSON.parse(Plasmoid.configuration.freePositions || "{}"); } catch (e) { all = {}; }
        const bucket = (all && all[key]) ? all[key] : {};
        if (bucket && bucket[url]) return bucket[url];
        return null;
    }

    function positionFor(idx, axis) {
        const p = storedPos(idx);
        const d = (p && p.length >= 2) ? p : defaultPos(idx);
        return d[axis];
    }

    function updatePosition(idx, x, y) {
        const key = screenKey();
        const url = urlForIndex(idx);
        if (!url) return;
        let all = {};
        try { all = JSON.parse(Plasmoid.configuration.freePositions || "{}"); } catch (e) { all = {}; }
        if (!all[key]) all[key] = {};
        all[key][url] = [Math.round(x), Math.round(y)];
        Plasmoid.configuration.freePositions = JSON.stringify(all);
    }

    Folder.FolderModel {
        id: dir

        usedByContainment: main.isRootView && Plasmoid.isContainment
        sortDesc: Plasmoid.configuration.sortDesc
        sortDirsFirst: Plasmoid.configuration.sortDirsFirst
        parseDesktopFiles: (Plasmoid.configuration.url === "desktop:/")
        previews: Plasmoid.configuration.previews
        previewPlugins: Plasmoid.configuration.previewPlugins
        applet: Plasmoid

        onRequestRename: { }
        onPopupMenuAboutToShow: (dropJob, mimeData, x, y) => {
            if (Plasmoid.isContainment && !Plasmoid.immutable) {
                // handled by containment drop area
            }
        }
    }

    Binding {
        target: dir
        property: "url"
        value: Plasmoid.configuration.url
    }

    Item {
        id: canvas
        anchors.fill: parent
    }

    Repeater {
        id: repeater
        model: dir

        delegate: MacFreeIcon {
            required property int index
            required property string display
            required property var decoration

            modelIndex: index
            folderModel: dir
            labelText: display
            iconSource: decoration
            iconPixels: main.iconPixels
            locked: main.locked
            folderView: main

            x: main.positionFor(index, 0)
            y: main.positionFor(index, 1)
        }
    }

    Component.onCompleted: {
        // load not needed; storedPos reads config
    }
}
