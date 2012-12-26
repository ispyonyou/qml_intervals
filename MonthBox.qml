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
            state = "FULLSELECTED"
//            color = "blue"
        else if(selected == _select_PartSelected)
            state = "PARTSELECTED"
//            color = "lightblue"
        else
            state = "UNSELECTED"
//            color = "darkgray"
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

    states: [
        State{
            name: "UNSELECTED"
            PropertyChanges { target: button1; color: "darkgray" }
        },
        State{
            name: "FULLSELECTED"
            PropertyChanges { target: button1; color: "blue" }
        },
        State{
            name: "PARTSELECTED"
            PropertyChanges { target: button1; color: "lightblue" }
        }
    ]

    transitions: [
        Transition {
            from: "UNSELECTED"; to: "PARTSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "darkgray"; to: "lightblue"; duration: 200 }
        },
        Transition {
            from: "UNSELECTED"; to: "FULLSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "darkgray"; to: "blue"; duration: 200 }
        },

        Transition {
            from: "PARTSELECTED"; to: "UNSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "lightblue"; to: "darkgray"; duration: 200 }
        },
        Transition {
            from: "PARTSELECTED"; to: "FULLSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "lightblue"; to: "blue"; duration: 200 }
        },

        Transition {
            from: "FULLSELECTED"; to: "UNSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "blue"; to: "darkgray"; duration: 200 }
        },
        Transition {
            from: "FULLSELECTED"; to: "PARTSELECTED"
            ColorAnimation { target: button1; properties: "color"; from: "blue"; to: "lightblue"; duration: 200 }
        }
    ]
}
