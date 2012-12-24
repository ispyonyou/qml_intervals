import QtQuick 1.1

Rectangle {
    id : dayBox

    property date day
    onDayChanged : { 
        buttonText.text = Qt.formatDate(day, "d" )
    }

    property int boxtype: intervalCtrl.boxType_DayBox

    property bool selected: false
    onSelectedChanged: {
        setColor();
    }

    property bool tempSelected: false
    onTempSelectedChanged: {
        setColor();
    }

    property bool tempUnselected: false
    onTempUnselectedChanged: {
        setColor();
    }

    function setColor() {
        if(tempSelected) {
            color = "blue"
        }
        else if(tempUnselected) {
            color = "darkgray"
        }
        else {
            if(selected == true)
                color = "blue"
            else
                color = "darkgray"
        }
    }

    width: 18; height: 18
    color: "darkgray"
    radius: 9
    smooth: true
    opacity: 0.7

    Text {
        id: buttonText
        anchors.horizontalCenter: dayBox.horizontalCenter
        anchors.verticalCenter: dayBox.verticalCenter
        font.pointSize: 8;
    }
}
