import Qt 4.7

Rectangle {
    
    property date year
    property int boxtype: 1


    onYearChanged : buttonText.text = Qt.formatDate(year, "yyyy" )

    id: button1
    width: 18; height: 227
    color: "darkgray"
    radius: 2
    smooth: true


    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent        

//        hoverEnabled : true
//        onEntered: intervalCtrl.onBoxEntered(1, parent.year)
    }
    Text {
        id: buttonText
        anchors.horizontalCenter: button1.horizontalCenter
        anchors.verticalCenter: button1.verticalCenter
        font.pointSize: 8;

        transform: Rotation {
            angle: 45
        }
    }
}
