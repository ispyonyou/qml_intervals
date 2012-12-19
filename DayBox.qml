import QtQuick 1.1

Rectangle {

    property date day
    property int boxtype: 4

    onDayChanged : buttonText.text = Qt.formatDate(day, "d" )

    id: button1
    width: 18; height: 18
    color: "darkgray"
    radius: 2
    smooth: true

    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent  

        preventStealing: true
        
//        hoverEnabled : true
//        onEntered: intervalCtrl.onBoxEntered(4, parent.day)

        onPositionChanged:
        {
            var a = intervalCtrl.mapFromItem(buttonMouseArea, x, y)
            console.log(a.x + "; " + a.y)

            var a = intervalCtrl.mapFromItem(buttonMouseArea, mouse.x, mouse.y)
            console.log(a.x + "; " + a.y )

            console.log("asdf" + intervalCtrl.x + "; " + intervalCtrl.y)

            var asd = intervalCtrl.y
            console.log(asd)
            asd += 1

            if( intervalCtrl.y < 0 ){
                intervalCtrl.y = asd;
                console.log("aaa" + intervalCtrl.y)
            }

//            var item = intervalCtrl.childAt(a.x, a.y)
//            console.log(item)
//            console.log(item.id)
//            console.log(item.year)
//            console.log(typeof(item))
        }      
    }
    Text {
        id: buttonText
        anchors.horizontalCenter: button1.horizontalCenter
        anchors.verticalCenter: button1.verticalCenter
        font.pointSize: 8;
    }
}
