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
            spacing: 10

            // 0 - no select
            // 1 - select
            // 2 - unselect
            property int selectMode: 0 

            property Item startSelectionItem: null
            property Item endSelectionItem: null
        
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

                function getItemUnderMouth(mouse, printBoxes)
                {
                    var item = intervalCtrl.childAt(mouse.x, mouse.y)
                    
                    // YearRow      
                    if(item && item.boxtype == 11)
                    {
                        var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                        item = item.childAt(itemMouse.x, itemMouse.y)

                        // YearBox
                        if(item && item.boxtype == 1)
                        {
                            if(printBoxes)
                                console.log( "YearBox - " + Qt.formatDate(item.year, "yyyy" ) )
                            return item;
                        }

                        // Column of month rows
                        if(item && item.boxtype == 12)
                        {
                            var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                            item = item.childAt(itemMouse.x, itemMouse.y)

                            // MonthRow
                            if(item && item.boxtype == 13)
                            {
                                var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                                item = item.childAt(itemMouse.x, itemMouse.y)

                                // MonthBox
                                if(item && item.boxtype == 2)
                                {
                                    if(printBoxes)
                                        console.log( "MonthBox - " + Qt.formatDate(item.month, "yyyy/MM" ) )
                                    return item;
                                }

                                // DayBox
                                if(item && item.boxtype == 4)
                                {
                                    if(printBoxes)
                                        console.log( "DayBox - " + Qt.formatDate(item.day, "yyyy/MM/d" ) )
                                    return item;
                                }
                            }
                        }
                    }

                    return null;
                }

                onPressed:
                {
                    console.log("onPressed")
                    var item = getItemUnderMouth(mouse, true)

                    if(item && !item.selected)
                        intervalCtrl.selectMode = 1
                    else if(item && item.selected)
                        intervalCtrl.selectMode = 2
                    else 
                        intervalCtrl.selectMode = 0

                    if(item && intervalCtrl.selectMode)
                        intervalCtrl.startSelectionItem = item

                }

                onReleased:
                {
                    console.log("onPressed")
                    intervalCtrl.selectMode = 0
                }

                onPositionChanged:
                {
                    var item = getItemUnderMouth(mouse, true);

                    var prevEndSelectionItem = intervalCtrl.endSelectionItem;
                    if(item && intervalCtrl.selectMode != 0)
                        intervalCtrl.endSelectionItem = item;

                    if(intervalCtrl.endSelectionItem != prevEndSelectionItem)
                    {
                        console.log("The selection algoritm implementation will be here")
                    }

                    if(item)
                    {
                        if(intervalCtrl.selectMode == 1)
                            item.selected = true;
                        else if(intervalCtrl.selectMode == 2)
                            item.selected = false;
                    }
                }
            }

    }
}
    