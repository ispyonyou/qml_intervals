import QtQuick 1.1

Item {
    id : dayBox
    property int boxtype: intervalCtrl.boxType_DayBox

    width: 18; height: 18
    opacity: 0.7
    state: "UNSELECTED"

    property date day
    onDayChanged : { 
        buttonText.text = Qt.formatDate(day, "d" )
    }

    property bool selected: false
    onSelectedChanged: {
//        animFromTmpSel.duration = 1000
//        animFromTmpUnSel.duration = 1000
        setState()
    }

    property bool tempSelected: false
    onTempSelectedChanged: {
//        animFromTmpSel.duration = 0
//        animFromTmpUnSel.duration = 0
        setState()
    }

    property bool tempUnselected: false
    onTempUnselectedChanged: {
//        animFromTmpSel.duration = 0
//        animFromTmpUnSel.duration = 0
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

    Rectangle {
        id: dayBoxBackground

        width: 4; height: 4

        x: 0; y: 0

//        anchors.top: parent.top
//        anchors.left: parent.left

        color: "black"

        radius: 2
        smooth: true

        visible: false
    }

    Rectangle {
        id: dayBoxForeground

        anchors.fill: parent
        color: "darkgray"
        radius: 9
        smooth: true


        Text {
            id: buttonText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 8;
        }
    }

    states: [
        State {
            name: "UNSELECTED"
            PropertyChanges { target: dayBoxForeground; color: "darkgray" }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: dayBoxForeground; color: "blue" }
        },
        State {
            name: "TMPSELECTED"
            PropertyChanges { target: dayBoxForeground; color: "blue" }
            PropertyChanges { target: dayBoxBackground; visible: true; x: 0 }
        },
        State {
            name: "TMPUNSELECTED"
            PropertyChanges { target: dayBoxForeground; color: "darkgray" }
            PropertyChanges { target: dayBoxBackground; visible: true; x: 0 }
        }
    ]

    transitions: [
        Transition {
            from: "UNSELECTED"; to: "SELECTED"
            NumberAnimation { id: animFromTmpSel; target: dayBoxBackground; properties: "x"; from: 0; to: 14; duration: 400 }
            SequentialAnimation {
                NumberAnimation { target: dayBoxBackground; property: "visible"; from: 1; to: 0; duration: 400 }
            }
        },
        Transition {
            from: "SELECTED"; to: "UNSELECTED"
            NumberAnimation { target: dayBoxBackground; properties: "x"; from: 14; to: 0; duration: 400 }
            SequentialAnimation {
                NumberAnimation { target: dayBoxBackground; property: "visible"; from: 1; to: 0; duration: 400 }
            }
        }
    ]
}
