import Qt 4.7

Rectangle {
    property date month
    onMonthChanged : buttonText.text = Qt.formatDate(month, "MMMM" )

    property int boxtype: intervalCtrl.boxType_MonthBox

    property color clrMonthBox_Unsel      : "#E7EEFB"
    property color clrMonthBox_PartSel    : "#C6CEDD"
    property color clrMonthBox_FullSel    : "#A5AFC0"
    property color clrMonthBox_Text       : "#397EA9"
    property color clrMonthBox_UnderMouse : "yellow"

    property int _select_Unselected  : 0;
    property int _select_FullSelected: 1;
    property int _select_PartSelected: 2;

    property int selected : _select_Unselected
    onSelectedChanged : { setState(); }

    property bool isUnderMouth: false
    onIsUnderMouthChanged: {
        if(isUnderMouth) 
            state = "UNDERMOUTH"
        else
            setState();
    }

    function setState() {
        if(selected == _select_FullSelected)
            state = "FULLSELECTED"
        else if(selected == _select_PartSelected)
            state = "PARTSELECTED"
        else
            state = "UNSELECTED"
    }

    id: button1
    width: 120; height: 18
    color: clrMonthBox_Unsel
    radius: 3
    smooth: true

    Text {
        id: buttonText
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.verticalCenter : parent.verticalCenter
        font.pointSize: 10;
        color: clrMonthBox_Text
    }

    states: [
        State{
            name: "UNSELECTED"
            PropertyChanges { target: button1; color: clrMonthBox_Unsel }
        },
        State{
            name: "FULLSELECTED"
            PropertyChanges { target: button1; color: clrMonthBox_FullSel }
        },
        State{
            name: "PARTSELECTED"
            PropertyChanges { target: button1; color: clrMonthBox_PartSel }
        },
        State {
            name: "UNDERMOUTH"
            PropertyChanges { target: button1; color: clrMonthBox_UnderMouse }
        }

    ]

    transitions: [
        Transition {
            from: "UNSELECTED"; to: "PARTSELECTED"
            ColorAnimation { target: button1; properties: "color"; to: clrMonthBox_PartSel; duration: 200 }
        },
        Transition {
            from: "UNSELECTED"; to: "FULLSELECTED"
            ColorAnimation { target: button1; properties: "color";  to: clrMonthBox_FullSel; duration: 200 }
        },

        Transition {
            from: "PARTSELECTED"; to: "UNSELECTED"
            ColorAnimation { target: button1; properties: "color"; to: clrMonthBox_Unsel; duration: 200 }
        },
        Transition {
            from: "PARTSELECTED"; to: "FULLSELECTED"
            ColorAnimation { target: button1; properties: "color"; to: clrMonthBox_FullSel; duration: 200 }
        },
        Transition {
            from: "FULLSELECTED"; to: "UNSELECTED"
            ColorAnimation { target: button1; properties: "color"; to: clrMonthBox_Unsel; duration: 200 }
        },
        Transition {
            from: "FULLSELECTED"; to: "PARTSELECTED"
            ColorAnimation { target: button1; properties: "color"; to: clrMonthBox_PartSel; duration: 200 }
        }
    ]
}
