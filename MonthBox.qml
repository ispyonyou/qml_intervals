import Qt 4.7

Rectangle {

    property date month
    onMonthChanged : buttonText.text = Qt.formatDate(month, "MMMM" )

    property int boxtype: intervalCtrl.boxType_MonthBox

    property int _select_Unselected  : 0;
    property int _select_FullSelected: 1;
    property int _select_PartSelected: 2;

    property int selected : _select_Unselected
    onSelectedChanged : {
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

    Text {
        id: buttonText
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.verticalCenter : parent.verticalCenter
        font.pointSize: 8;
    }
}
