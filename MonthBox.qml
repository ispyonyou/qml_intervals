import Qt 4.7

Rectangle {

    property date month
    property int boxtype: 2


    onMonthChanged : buttonText.text = Qt.formatDate(month, "MMMM" )

    id: button1
    width: 200; height: 18
    color: "darkgray"
    radius: 2
    smooth: true

    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent        

//        hoverEnabled : true
//        onEntered: intervalCtrl.onBoxEntered(2, parent.month)
    }
    Text {
        id: buttonText
        text: "January"
        anchors.horizontalCenter: button1.horizontalCenter
        anchors.verticalCenter: button1.verticalCenter
        font.pointSize: 8;
    }
}
