import QtQuick 1.1
//import "QtDesktop"

Rectangle
{
    width: 900; height: 500

    Flickable{
        width: 900; height: 500
        contentWidth: intervalCtrl.width; contentHeight: intervalCtrl.height

        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick

        Column{
            id: intervalCtrl
//            anchors.centerIn: parent
            spacing: 10
        
            function onBoxEntered(box, dt)
            {
                if( box == 1 ) // YearBox
                    console.log( "YearBox - " + Qt.formatDate(dt, "yyyy" ) )
                else if( box == 2 ) // MonthBox
                    console.log( "MonthBox - " + Qt.formatDate(dt, "yyyy/MM" ) )
                else if( box == 4 ) // DayBox
                    console.log( "DayBox - " + Qt.formatDate(dt, "yyyy/MM/d" ) )
            }
        
            YearRow{
                year: "2011-01-01"
                id: asdf
            }
        
            YearRow{
                year: "2012-01-01"
            }
        
            YearRow{
                year: "2013-01-01"
            }
        
        }
        MouseArea {
                id: buttonMouseArea1
                objectName: "buttonMouseArea1"
                anchors.fill: parent

                preventStealing: true

                onPositionChanged:
                {
                    var item = intervalCtrl.childAt(mouse.x, mouse.y)

                    if(item && item.boxtype == 11) {// YearRow

                        var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
//                        console.log( "mouse - " + mouse.x + "; " + mouse.y )
//                        console.log( "itemMouse - " + itemMouse.x + "; " + itemMouse.y )

                        var item1 = item.childAt(itemMouse.x, itemMouse.y)

                        // YearBox
                        if(item1 && item1.boxtype == 1){
                            console.log( "YearBox - " + Qt.formatDate(item1.year, "yyyy" ) )
                            return;
                        }

                        // column of month rows
                        if( item1 && item1.boxtype == 12 )
                        {
                            var itemMouse = item1.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)

                            var item2 = item1.childAt(itemMouse.x, itemMouse.y)

                            // MonthRow
                            if(item2 && item2.boxtype == 13)
                            {
                                var itemMouse = item2.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)

                                var item3 = item2.childAt(itemMouse.x, itemMouse.y)

                                // MonthBox
                                if(item3 && item3.boxtype == 2)
                                {
                                    console.log( "MonthBox - " + Qt.formatDate(item3.month, "yyyy/MM" ) )
                                    return;
                                }

                                // DayBox
                                if(item3 && item3.boxtype == 4)
                                {
                                    console.log( "DayBox - " + Qt.formatDate(item3.day, "yyyy/MM/d" ) )
                                    return;
                                }

                                console.log( item3 )
                                return;
                            }

                            return;
                        }
                    }
                }
            }

    }
}
    