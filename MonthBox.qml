import Qt 4.7

Rectangle {

    property date month
    onMonthChanged : buttonText.text = Qt.formatDate(month, "MMMM" )

    property int boxtype: 2

    property bool selected: false
    onSelectedChanged: 
    {
        if(selected == true)
            color = "blue"
        else
            color = "darkgray"
    }

    id: button1
    width: 120; height: 18
    color: "darkgray"
    radius: 9
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
