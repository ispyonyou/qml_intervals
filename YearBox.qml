import Qt 4.7

Rectangle {
    
    property date year
    property int boxtype: 1

    onYearChanged : buttonText.text = Qt.formatDate(year, "yyyy" )

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
    width : 18; height : 227
    color : "darkgray"
    radius : 9
    smooth : true
    opacity : 0.7
    
    Text {
        id : buttonText
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.verticalCenter : parent.verticalCenter
        font.pointSize : 8;

        rotation : 90
    }
}
