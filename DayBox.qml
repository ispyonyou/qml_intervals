import QtQuick 1.1

Rectangle {
    id : dayBox
    property int boxtype: intervalCtrl.boxType_DayBox

    width: 18; height: 18
    radius: 3
    smooth: true

    state: "UNSELECTED"

    property color clrDayBox_Unsel      : "#E7EEFB"
    property color clrDayBox_Sel        : "#A5AFC0"
    property color clrDayBox_Text       : "black"
    property color clrDayBox_UnderMouse : "yellow"

    property date day
    onDayChanged : { 
        buttonText.text = Qt.formatDate(day, "d" )
        var weekDay = day.getDay()
        if(weekDay == 6 || weekDay == 0)
            isHolyday = true;
    }

    property bool isHolyday
    onIsHolydayChanged: {
        clrDayBox_Unsel = "#E7EEFB";
        clrDayBox_Sel = "#A5AFC0";
        clrDayBox_UnderMouse = "yellow"

        if(!isHolyday){
            clrDayBox_Text = "black";
        }
        else {
            clrDayBox_Text = "red";
        }
    }

    property bool selected: false
    onSelectedChanged: { setState() }

    property bool tempSelected: false
    onTempSelectedChanged: { setState() }

    property bool tempUnselected: false
    onTempUnselectedChanged: { setState() }

    property bool isUnderMouth: false
    onIsUnderMouthChanged: {
        if(isUnderMouth) 
            state = "UNDERMOUTH"
        else
            setState();
    }

    function setState() {
        if(tempSelected)
            state = "TMPSELECTED"
        else if(tempUnselected)
            state = "TMPUNSELECTED"
        else
            state = selected ? "SELECTED" : "UNSELECTED";
    }

    Text {
        id: buttonText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 8;

        color: parent.clrDayBox_Text
    }


    states: [
        State {
            name: "UNSELECTED"
            PropertyChanges { target: dayBox; color: clrDayBox_Unsel }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: dayBox; color: clrDayBox_Sel }
        },
        State {
            name: "TMPUNSELECTED"
            PropertyChanges { target: dayBox; color: clrDayBox_Unsel }
        },
        State {
            name: "TMPSELECTED"
            PropertyChanges { target: dayBox; color: clrDayBox_Sel }
        },
        State {
            name: "UNDERMOUTH"
            PropertyChanges { target: dayBox; color: clrDayBox_UnderMouse }
        }
    ]

    transitions: [
        Transition {
            from: "*"; to: "TMPSELECTED"
            ColorAnimation { target: dayBox; properties: "color"; from: clrDayBox_Unsel; to: clrDayBox_Sel; duration: 100 }
        },
        Transition {
            from: "*"; to: "TMPUNSELECTED"
            ColorAnimation { target: dayBox; properties: "color"; from: clrDayBox_Sel; to: clrDayBox_Unsel; duration: 100 }
        }
    ]
}
