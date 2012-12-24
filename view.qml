import QtQuick 1.1
//import "QtDesktop"

Rectangle
{
    id: ctrl
    
    width: 900; height: 500

    property variant yearRows: [];


    ScrollBar{
        width: parent.width - flick.width
        height: parent.height
    }

    Flickable{
        id: flick

        width: 800; height: 500
        contentWidth: intervalCtrl.width; contentHeight: intervalCtrl.height

//        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick

        YearsColumn{
            id: intervalCtrl
//            spacing: 10

            property variant yearRows: [];

            property int _boxType_YearBox   :  1
            property int _boxType_MonthBox  :  2
            property int _boxType_DayBox    :  4
            property int _boxType_YearRow   : 11
            property int _boxType_MonthesCol: 12
            property int _boxType_MonthRow  : 13

            property int _selMode_NoSelect: 0
            property int _selMode_Select  : 1
            property int _selMode_Unselect: 2

            property int selMode: _selMode_NoSelect

            property Item boxUnderMouth: null

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

            YearRow{
                year: "2014-01-01"
            }

            YearRow{
                year: "2015-01-01"
            }

            YearRow{
                year: "2016-01-01"
            }        
        }
        MouseArea {
                id: buttonMouseArea1
                objectName: "buttonMouseArea1"
                anchors.fill: parent

                hoverEnabled : true
                preventStealing: true

                function getItemUnderMouth(mouse, printBoxes)
                {
                    var item = intervalCtrl.childAt(mouse.x, mouse.y)

                    if(item && item.boxtype == intervalCtrl._boxType_YearRow)
                    {
                        var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                        item = item.childAt(itemMouse.x, itemMouse.y)

                        if(item && item.boxtype == intervalCtrl._boxType_YearBox)
                            return item;

                        if(item && item.boxtype == intervalCtrl._boxType_MonthesCol)
                        {
                            var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                            item = item.childAt(itemMouse.x, itemMouse.y)

                            if(item && item.boxtype == intervalCtrl._boxType_MonthRow)
                            {
                                var itemMouse = item.mapFromItem(buttonMouseArea1, mouse.x, mouse.y)
                                item = item.childAt(itemMouse.x, itemMouse.y)

                                if(item && item.boxtype == intervalCtrl._boxType_MonthBox)
                                    return item;

                                if(item && item.boxtype == intervalCtrl._boxType_DayBox )
                                    return item;
                            }
                        }
                    }

                    return null;
                }

                function getFirstDate(box)
                {
                    switch(box.boxtype)
                    {
                        case intervalCtrl._boxType_DayBox:
                            return box.day;
                        case intervalCtrl._boxType_MonthBox:
                            return new Date(box.month.getFullYear(), box.month.getMonth(), 1)
                        case intervalCtrl._boxType_YearBox:
                            return new Date(box.year.getFullYear(), 0, 1)
                    }

                    console.log("Error. getFirstDate(). Unsupported item type"); null = 1;
                    return null;
                }

                function getLastDate(box)
                {
                    switch(box.boxtype)
                    {
                        case intervalCtrl._boxType_DayBox:
                            return box.day;
                        case intervalCtrl._boxType_MonthBox:
                        {
                            var year = box.month.getFullYear();
                            var month = box.month.getMonth();
                            return new Date(year, month, 32 - new Date(year, month, 32).getDate());
                        }
                        case intervalCtrl._boxType_YearBox:
                            return new Date(box.year.getFullYear(), 11, 31);
                    }

                    console.log("Error. getLastDate(). Unsupported item type"); null = 1;
                    return null;
                }

                function getIntervalBetweenBoxes(box1, box2)
                {
                    var box1_firstDay = getFirstDate(box1);
                    var box1_lastDay = getLastDate(box1);

                    var box2_firstDay = getFirstDate(box2);
                    var box2_lastDay = getLastDate(box2);

                    if( box1.boxtype == intervalCtrl._boxType_YearBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear())
                        return [box1_firstDay, box1_lastDay];

                    if( box2.boxtype == intervalCtrl._boxType_YearBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear())
                        return [box2_firstDay, box2_lastDay];

                    if( box1.boxtype == intervalCtrl._boxType_MonthBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear() && box1_firstDay.getMonth() == box2_firstDay.getMonth())
                        return [box1_firstDay, box1_lastDay];

                    if( box2.boxtype == intervalCtrl._boxType_MonthBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear() && box1_firstDay.getMonth() == box2_firstDay.getMonth())
                        return [box2_firstDay, box2_lastDay];

                    return (box1_firstDay < box2_firstDay) ? [box1_firstDay, box2_lastDay] : [box2_firstDay, box1_lastDay];
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

                        var checkYearSelected = false;

                        for(var m = 0; m < 12; m++ )
                        {
                            var monthRow = monthesColumn.children[m];
                            var daysRepeater = monthRow.children[monthRow.children.length-1];

                            var chekMonthSelected = false;

                            for(var d = 1; d <= daysRepeater.model; d++)
                            {
                                var dt = new Date(y, m, d);
                                if(from <= dt && dt <= to)
                                {
                                    chekMonthSelected = true;

                                    var dayBox = monthRow.children[d];
                                    if(is_tmp_selection)
                                    {
                                        if(intervalCtrl.selMode == intervalCtrl._selMode_Select)
                                            dayBox.tempSelected = is_select;
                                        else
                                            dayBox.tempUnselected = is_select;
                                    }
                                    else
                                        dayBox.selected = is_select;
                                }
                            }

                            if(chekMonthSelected)
                            {
                                checkYearSelected = true;

                                var monthBox = monthRow.children[0];
                                var selectedCnt = 0;

                                for(var d = 1; d <= daysRepeater.model; d++)
                                {
                                    var dayBox = monthRow.children[d];
                                    var selected = false;

                                    if(dayBox.tempSelected)
                                        selected = true;
                                    else if(dayBox.tempUnselected)
                                        selected = false;
                                    else
                                        selected = dayBox.selected;

                                    if(selected)
                                        selectedCnt += 1;
                                }

                                if(!selectedCnt)
                                    monthBox.selected = monthBox._select_Unselected;
                                else if(selectedCnt < daysRepeater.model)
                                    monthBox.selected = monthBox._select_PartSelected;
                                else
                                    monthBox.selected = monthBox._select_FullSelected;
                            }
                        }

                        if(checkYearSelected)
                        {
                            var unSelectedCnt = 0;
                            var fullSelectedCnt = 0;

                            for(var m = 0; m < 12; m++ )
                            {
                                var monthRow = monthesColumn.children[m];
                                var monthBox = monthRow.children[0];

                                if(monthBox.selected == monthBox._select_Unselected)
                                    unSelectedCnt++;
                                else if(monthBox.selected == monthBox._select_FullSelected)
                                    fullSelectedCnt++;
                            }

                            var yearRow = intervalCtrl.children[y - firstYear];
                            var yearBox = yearRow.children[0];

                            if(unSelectedCnt == 12)
                                yearBox.selected = yearBox._select_Unselected;
                            else if(fullSelectedCnt == 12)
                                yearBox.selected = yearBox._select_FullSelected;
                            else 
                                yearBox.selected = yearBox._select_PartSelected;
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

                    if(intervalCtrl.startSelBox.boxtype == intervalCtrl._boxType_DayBox)
                        intervalCtrl.selMode = intervalCtrl.startSelBox.selected ? intervalCtrl._selMode_Unselect 
                                                                                 : intervalCtrl._selMode_Select;
                    else if(intervalCtrl.startSelBox.boxtype == intervalCtrl._boxType_MonthBox){
                        var monthBox = intervalCtrl.startSelBox;

                        intervalCtrl.selMode = 
                            monthBox.selected == monthBox._select_Unselected ? intervalCtrl._selMode_Select 
                                                                             : intervalCtrl._selMode_Unselect;
                    }
                    else if(intervalCtrl.startSelBox.boxtype == intervalCtrl._boxType_YearBox){
                        var yearBox = intervalCtrl.startSelBox;

                        intervalCtrl.selMode = 
                            yearBox.selected == yearBox._select_Unselected ? intervalCtrl._selMode_Select 
                                                                           : intervalCtrl._selMode_Unselect;
                    }
                    else {
                        console.log("Error. onPressed(). Unsupported item type"); null = 1;
                    }

                    intervalCtrl.endSelBox = intervalCtrl.startSelBox;

                    doSelection();
                }

                onReleased:
                {
                    if(intervalCtrl.selMode != intervalCtrl._selMode_NoSelect)
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

                    if(intervalCtrl.boxUnderMouth && intervalCtrl.boxUnderMouth != box)
                        intervalCtrl.boxUnderMouth.opacity = 0.7;

                    intervalCtrl.boxUnderMouth = box;
                    if(intervalCtrl.boxUnderMouth)
                        intervalCtrl.boxUnderMouth.opacity = 1;                    

                    var prevEndSelBox = intervalCtrl.endSelBox;
                    if(box && intervalCtrl.selMode != intervalCtrl._selMode_NoSelect)
                        intervalCtrl.endSelBox = box;

                    if(intervalCtrl.startSelBox && intervalCtrl.endSelBox != prevEndSelBox)
                        doSelection();
                }

                onExited:
                {
                    if(intervalCtrl.boxUnderMouth)
                        intervalCtrl.boxUnderMouth.opacity = 0.7;

                    intervalCtrl.boxUnderMouth = null;
                }
            }
    }
}
    