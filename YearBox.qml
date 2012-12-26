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
//            color = "blue"
            state = "FULLSELECTED"
        else if(selected == _select_PartSelected)
//            color = "lightblue"
            state = "PARTSELECTED"
        else
//            color = "darkgray"
            state = "UNSELECTED"
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
