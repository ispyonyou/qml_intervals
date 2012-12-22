import QtQuick 1.1

Rectangle {

    property date day
    onDayChanged : buttonText.text = Qt.formatDate(day, "d" )

    property int boxtype: 4

    property bool selected: false
    onSelectedChanged:
    {
        setColor();
    }

    property bool tempSelected: false
    onTempSelectedChanged:
    {
        setColor();
    }

    property bool tempUnselected: false
    onTempUnselectedChanged:
    {
        setColor();
    }

    function setColor()
    {
        if(tempSelected)
        {
//            if(intervalCtrl.selMode == intervalCtrl._selMode_Select)
                color = "blue"
//            else
//                color = "darkgray"
        }
        else if(tempUnselected)
        {
            color = "darkgray"
        }
        else
        {
            if(selected == true)
                color = "blue"
            else
                color = "darkgray"
        }
    }

    id: button1
    width: 18; height: 18
    color: "darkgray"
    radius: 9
    smooth: true
    opacity: 0.7

    MouseArea {
        id: buttonMouseArea
        objectName: "buttonMouseArea"
        anchors.fill: parent  

        preventStealing: true

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
