import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

import "../delegates"
import "../styles"

Item {
    id: root

    property variant model: null // resources model
    property real thumbnailSize: 120
    property bool selectable: false

    function getSelectionList() {
        var selectionList = [];
        for(var i = root.model.resources.length; i > 0 ; i--) {
            if(grid.contentItem.children[i-1].selected) {
                selectionList.push(root.model.resources[i-1].url);
            }
        }
        return selectionList;
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // gallery
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            GridView {
                id: grid
                anchors.fill: parent
                cellWidth: root.thumbnailSize
                cellHeight: root.thumbnailSize
                model: root.model ? root.model.resources : 0
                delegate: ResourceGridDelegate {
                    onItemClicked: {
                        if(!root.selectable)
                            return;
                        toggleSelectedState();
                    }
                    onItemDoubleClicked: {
                        if(!root.selectable)
                            return;
                        if(modelData.isDir())
                            return;
                    }
                }
                clip: true
            }
        }
    }
    Slider {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 50
        height: 10
        minimumValue: 100
        maximumValue: 300
        value: 120
        onValueChanged: root.thumbnailSize = value
    }
}