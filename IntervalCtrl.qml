import QtQuick 1.1

Rectangle
{
    id: ctrl
    
    width: 754; height: 500

    ScrollBar{
        width: parent.width - flick.width
        height: parent.height
    }

    Flickable{
        id: flick

        width : 732; height : ctrl.height
        contentWidth : intervalCtrl.width; contentHeight : intervalCtrl.height

        flickableDirection : Flickable.VerticalFlick

        Behavior on contentY { NumberAnimation { duration: 200 } }


        YearsColumn {
            id: intervalCtrl

            width: flick.width; height: flick.height
            anchors.left: parent.left

            YearRow{ year: "2011-01-01" }
            YearRow{ year: "2012-01-01" }
            YearRow{ year: "2013-01-01" }
            YearRow{ year: "2014-01-01" }
        }

        MouseArea {
            id : mouseArea

            width : flick.contentWidth; height : flick.contentHeight
            anchors.left : parent.left

            hoverEnabled : true
            preventStealing : true

            onPressed : {
                var box = intervalCtrl.getBoxUnderMouse(mouse, mouseArea)
                intervalCtrl.startSelection(box)
            }

            onReleased : {
                intervalCtrl.endSelection();
            }

            onPositionChanged : {
                var box = intervalCtrl.getBoxUnderMouse(mouse, mouseArea);
                intervalCtrl.performHighlight(box);
                intervalCtrl.performSelection(box);
            }

            onExited : {
                intervalCtrl.performHighlight(null);
            }
        }
    }
}
    