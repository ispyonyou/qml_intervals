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
        state = selected ? "SELECTED" : "UNSELECTED";
    }

    property bool tempSelected: false
    onTempSelectedChanged: {
        setState()
    }

    property bool tempUnselected: false
    onTempUnselectedChanged: {
        state = "TMPUNSELECTED"
        console.log(state)
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
        },
        State {
            name: "TMPUNSELECTED"
            PropertyChanges { target: dayBoxForeground; color: "darkgray" }
        }

    ]

 //   transitions: [
 //       Transition {
 //           from: "*"; to: "SELECTED"
 //           NumberAnimation { properties: "color"; duration: 200 }
 //       }
 //   ]
}
