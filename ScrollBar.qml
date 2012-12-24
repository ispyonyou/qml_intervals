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
                console.log(flick);
                console.log("contentWidth - " + flick.contentWidth);
                console.log("contentHeight - " + flick.contentHeight);
                console.log("contentX - " + flick.contentX );
                console.log("contentY - " + flick.contentY );

                if(!intervalCtrl.yearRows.length)
                    return;

                var newYear = new Date(intervalCtrl.yearRows[0].year);
                newYear.setYear(newYear.getFullYear()-1);

                var component = Qt.createComponent("YearRow.qml");
                var sprite = component.createObject(intervalCtrl, {"x": 0, "y": 0, "year": newYear});

                intervalCtrl.updatePositions();


//                for(var i = 0; i < intervalCtrl.yearRows.length; i++ ) {
//                    console.log("  " + intervalCtrl.yearRows[i].year);
//                }
//
//                var y = 0;
//                for(var i = 0; i < intervalCtrl.yearRows.length; i++ ) {
//                    intervalCtrl.children[i].y = y;
//                    y += 220;

//                    intervalCtrl.children[i].y += sprite.height * 2
//                    console.log(intervalCtrl.children[i].year)
//                }

//                sprite.y = 0


//                listView.positionViewAtBeginning();
//                listModel.insert( 0, {"mYear": listModel.get(0).mYear-1})
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