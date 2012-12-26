import QtQuick 1.1

Rectangle {
    id : dayBox
    property int boxtype: intervalCtrl.boxType_DayBox

    width: 18; height: 18
    opacity: 0.7
    radius: 9
    smooth: true

    state: "UNSELECTED"

    property date day
    onDayChanged : { 
        buttonText.text = Qt.formatDate(day, "d" )
    }

    property bool selected: false
    onSelectedChanged: {
        setState()
    }

    property bool tempSelected: false
    onTempSelectedChanged: {
        setState()
    }

    property bool tempUnselected: false
    onTempUnselectedChanged: {
        setState()
    }

    function setState() {
        if(tempSelected)
            state = "TMPSELECTED"
        else if(tempUnselected)
            state = "TMPUNSELECTED"
        else
            state = selected ? "SELECTED" : "UNSELECTED";
    }

//    Rectangle {
//        id: dayBoxForeground
//
//        anchors.fill: parent
//        color: "darkgray"
//        radius: 9
//        smooth: true
//    }

    Text {
        id: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 8;
    }


    states: [
        State {
            name: "UNSELECTED"
            PropertyChanges { target: dayBox; color: "darkgray" }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: dayBox; color: "blue" }
        },
        State {
            name: "TMPSELECTED"
            PropertyChanges { target: dayBox; color: "blue" }
        },
        State {
            name: "TMPUNSELECTED"
            PropertyChanges { target: dayBox; color: "darkgray" }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "TMPSELECTED"
            ColorAnimation { target: dayBox; properties: "color"; from: "darkgray"; to: "blue"; duration: 100 }
        },
        Transition {
            from: "*"; to: "TMPUNSELECTED"
            ColorAnimation { target: dayBox; properties: "color"; from: "blue"; to: "darkgray"; duration: 100 }
        }
    ]
}
