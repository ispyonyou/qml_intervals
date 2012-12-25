import QtQuick 1.1

Rectangle {
    width: parent.width - listView.width
    height: parent.height

    anchors.right: parent.right

    color: "transparent"

    Rectangle {
        width: parent.width - 4
        height: parent.width - 4

        anchors.right: parent.right
        anchors.top: parent.top

        radius: 11
        smooth: true

        color: "green"

        MouseArea {
            anchors.fill: parent 

            onClicked: {
                var newYear = new Date(intervalCtrl.getFirstYear()-1, 1, 1);

                var component = Qt.createComponent("YearRow.qml");
                var sprite = component.createObject(intervalCtrl, {"x": 0, "y": 0, "year": newYear});

                flick.contentY = 0
                intervalCtrl.updatePositions();
            }
        }
    }

    Rectangle {
        width: parent.width - 4
        height: parent.height - width * 2

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        radius: 11
        smooth: true

        color: "red"
    }

    Rectangle {
        width: parent.width - 4
        height: parent.width - 4

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        radius: 11
        smooth: true

        color: "green"
    }
}