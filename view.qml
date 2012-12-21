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

            property int _boxType_DayBox: 4;

            property int _selMode_NoSelect: 0
            property int _selMode_Select  : 1
            property int _selMode_Unselect: 2

            property int selMode: _selMode_NoSelect

            property Item startSelBox: null
            property Item endSelBox: null

            property variant startSelDate;
            property variant endSelDate;

            YearRow{
                year: "2011-01-01"
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

                                if(item && item.boxtype == intervalCtrl._boxType_DayBox )
                                    return item;
                            }
                        }
                    }

                    return null;
                }

                function getDay(box)
                {
                    if(box && box.boxtype == 4)
                        return box.day;

                    console.log("*** assert - function getDay(box)")
                }

                function getFirstDate(box)
                {
                    if(box.boxtype == 4)
                        return box.day;
                    else if(box.boxtype == 2)
                        return new Date(box.month.getYear(), box.month.getMonth(), 1)
                    else if(box.boxtype == 1)
                        return new Date(box.year.getYear(), 0, 1)
                }

                function getLastDate(box)
                {
                    if(box.boxtype == 4)
                        return box.day;
                    else if(box.boxtype == 2)
                    {
                        var year = box.month.getYear();
                        var month = box.month.getMonth();
                        return new Date(year, month, 32 - new Date(year, month, 32).getDate());
                    }
                    else if(box.boxtype == 1)
                        return new Date(box.year.getYear(), 11, 31);
                }

                function getIntervalBetweenBoxes(box1, box2)
                {
                    var box1_firstDay = getFirstDate(box1);
                    var box1_lastDay = getLastDate(box1);

                    var box2_firstDay = getFirstDate(box2);
                    var box2_lastDay = getLastDate(box2);

                    // day - day
                    if( box1.boxtype == 4 && box2.boxtype == 4 )
                    {
                        if( box1_firstDay < box2_firstDay )
                            return [box1_firstDay, box2_firstDay];
                        else
                            return [box2_firstDay, box1_firstDay]
                    }
                }

                function selection(from, to, is_tmp_selection, is_select)
                {
                    if(intervalCtrl.children.length == 0)
                        return;

                    var firstYear = intervalCtrl.children[0].year.getFullYear();
                    var lastYear = firstYear + intervalCtrl.children.length - 1;

                    for(var y = firstYear; y <= lastYear; y++)
                    {
                        if(!(from.getFullYear() <= y && y <= to.getFullYear()))
                            continue;

                        var yearRow = intervalCtrl.children[y - firstYear];
                        var monthesColumn = yearRow.children[1];

                        for(var m = 0; m < 12; m++ )
                        {
                            var monthRow = monthesColumn.children[m];
                            var daysRepeater = monthRow.children[monthRow.children.length-1];
                            for(var d = 1; d <= daysRepeater.model; d++)
                            {
                                var dt = new Date(y, m, d);
                                if(from <= dt && dt <= to)
                                {
                                    var dayBox = monthRow.children[d];
                                    if(is_tmp_selection)
                                        dayBox.tempSelected = is_select;
                                    else
                                        dayBox.selected = is_select;
                                }

                            }
                        }
                    }
                }

                function doSelection()
                {
                    if(!intervalCtrl.startSelBox || !intervalCtrl.endSelBox)
                        return null;

                    var prevStartSelDate = intervalCtrl.startSelDate;
                    var prevEndSelDate = intervalCtrl.endSelDate;

                    var interval = getIntervalBetweenBoxes(intervalCtrl.startSelBox, intervalCtrl.endSelBox);

                    intervalCtrl.startSelDate = interval[0];
                    intervalCtrl.endSelDate = interval[1];

                    if( !prevStartSelDate )
                        prevStartSelDate = intervalCtrl.startSelDate;

                    if( !prevEndSelDate )
                        prevEndSelDate = intervalCtrl.endSelDate;

                    if(prevStartSelDate < intervalCtrl.startSelDate)
                        selection(prevStartSelDate, intervalCtrl.startSelDate, true, false);

                    if(intervalCtrl.endSelDate < prevEndSelDate)
                        selection(intervalCtrl.endSelDate, prevEndSelDate, true, false);

                    selection(intervalCtrl.startSelDate, intervalCtrl.endSelDate, true, true);
                }

                function endSelection()
                {
                    selection(intervalCtrl.startSelDate, intervalCtrl.endSelDate, true, false)

                    var is_selection = true;
                    if( intervalCtrl.selMode == intervalCtrl._selMode_Select)
                        is_selection = true;
                    else
                        is_selection = false;

                    selection(intervalCtrl.startSelDate, intervalCtrl.endSelDate, false, is_selection)
                }

                onPressed:
                {
                    intervalCtrl.selMode = intervalCtrl._selMode_NoSelect;
                    intervalCtrl.startSelBox = null;
                    intervalCtrl.endSelBox = null;

                    intervalCtrl.startSelBox = getItemUnderMouth(mouse, false)
                    if(!intervalCtrl.startSelBox)
                        return;

                    intervalCtrl.selMode = intervalCtrl.startSelBox.selected ? intervalCtrl._selMode_Unselect 
                                                                                : intervalCtrl._selMode_Select;
                    intervalCtrl.endSelBox = intervalCtrl.startSelBox;

                    doSelection();
                }

                onReleased:
                {
                    endSelection();
                    intervalCtrl.selMode = intervalCtrl._selMode_NoSelect;
                    intervalCtrl.startSelBox = null;
                    intervalCtrl.endSelBox = null;
                    intervalCtrl.startSelDate = null;
                    intervalCtrl.endSelDate = null;
                }

                onPositionChanged:
                {
                    var box = getItemUnderMouth(mouse, false);

                    var prevEndSelBox = intervalCtrl.endSelBox;
                    if(box && intervalCtrl.selMode != intervalCtrl._selMode_NoSelect)
                        intervalCtrl.endSelBox = box;

                    if(intervalCtrl.endSelBox != prevEndSelBox)
                        doSelection();
                }
            }
    }
}
    