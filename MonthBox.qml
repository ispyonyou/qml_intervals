import Qt 4.7

Rectangle {

    property date month
    onMonthChanged : buttonText.text = Qt.formatDate(month, "MMMM" )

    property int boxtype: 2

    property int _select_Unselected  : 0;
    property int _select_FullSelected: 1;
    property int _select_PartSelected: 2;

    property int selected: _select_Unselected
    onSelectedChanged: 
    {
        if(selected == _select_FullSelected)
            color = "blue"
        else if(selected == _select_PartSelected)
            color = "lightblue"
        else
            color = "darkgray"
    }


    id: button1
    width: 120; height: 18
    color: "darkgray"
    radius: 9
    smooth: true
    opacity: 0.7

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
