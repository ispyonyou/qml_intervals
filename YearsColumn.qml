import QtQuick 1.1

Item
{
    id: yearsList

    property int boxType_YearBox   :  1
    property int boxType_MonthBox  :  2
    property int boxType_DayBox    :  4
    property int boxType_YearRow   : 11
    property int boxType_MonthesCol: 12
    property int boxType_MonthRow  : 13

    property int selMode_NoSelect: 0
    property int selMode_Select  : 1
    property int selMode_Unselect: 2

    property int selMode: selMode_NoSelect

    property Item startSelBox: null
    property Item endSelBox: null

    property variant startSelDate
    property variant endSelDate

    property bool isCompleted: false
    property Item animTarget: null

    property Item boxUnderMouth: null

    signal add

    onChildrenChanged : {
    }

    Component.onCompleted : {
        isCompleted = true;
        updatePositions();
    }

    onAdd: ParallelAnimation { 
        running: true
        PropertyAction { target: animTarget; property: "height"; value: 0 }
        NumberAnimation { target: animTarget; property: "height"; to: 240; duration: 800; easing.type: Easing.InOutQuad }
        PropertyAction { target: animTarget; property: "opacity"; value: 0 }
        NumberAnimation { target: animTarget; property: "opacity"; to: 1; duration: 800; easing.type: Easing.InOutQuad }    
    }

    function updatePositions() {
        if(!isCompleted)
            return;

        yearsList.height = 240 * yearsList.children.length;

        var minYear = getFirstYear();
        for(var i = 0; i < yearsList.children.length; i++ ) {
            console.log(yearsList.children[i].year.getFullYear())
            yearsList.children[i].y = 240 * ( yearsList.children[i].year.getFullYear() - minYear);
        }

        animTarget = yearsList.children[yearsList.children.length-1];

        yearsList.add();
    }

    function getFirstYear() {
        var minYear = 10000;
        for(var i = 0; i < yearsList.children.length; i++ )
            if( yearsList.children[i].year.getFullYear() < minYear )
                minYear = yearsList.children[i].year.getFullYear();

        return minYear;
    }

    function getYearRow(year) {
        for(var i = 0; i < yearsList.children.length; i++ )
            if( yearsList.children[i].year.getFullYear() == year )
                return yearsList.children[i];
    }

    function getBoxUnderMouse(mouse, mouseArea) {
        var item = yearsList.childAt(mouse.x, mouse.y)

        if(item && item.boxtype == boxType_YearRow) {
            var itemMouse = item.mapFromItem(mouseArea, mouse.x, mouse.y)
            item = item.childAt(itemMouse.x, itemMouse.y)

            if(item && item.boxtype == boxType_YearBox)
                return item;

            if(item && item.boxtype == boxType_MonthesCol) {
                var itemMouse = item.mapFromItem(mouseArea, mouse.x, mouse.y)
                item = item.childAt(itemMouse.x, itemMouse.y)

                if(item && item.boxtype == boxType_MonthRow) {
                    var itemMouse = item.mapFromItem(mouseArea, mouse.x, mouse.y)
                    item = item.childAt(itemMouse.x, itemMouse.y)

                    if(item && item.boxtype == boxType_MonthBox)
                        return item;

                    if(item && item.boxtype == boxType_DayBox)
                        return item;
                }
            }
        }

        return null;
    }

    function performHighlight(box) {
        if(boxUnderMouth && boxUnderMouth != box)
            boxUnderMouth.opacity = 0.7;

        boxUnderMouth = box;
        if(boxUnderMouth)
            boxUnderMouth.opacity = 1;                    
    }

    function startSelection(box){
        selMode = selMode_NoSelect;

        startSelBox = box;
        endSelBox = null;

        if(!startSelBox)
            return;

        if(startSelBox.boxtype == boxType_DayBox)
            selMode = startSelBox.selected ? selMode_Unselect : selMode_Select;
        else if(startSelBox.boxtype == boxType_MonthBox)
            selMode = startSelBox.selected == startSelBox._select_Unselected ? selMode_Select : selMode_Unselect;
        else if(startSelBox.boxtype == boxType_YearBox)
            selMode = startSelBox.selected == startSelBox._select_Unselected ? selMode_Select : selMode_Unselect;
        else {
            startSelBox = null;
            console.log("Error. onPressed(). Unsupported item type"); null = 1;
        }

        performSelection(startSelBox);
    }

    function endSelection() {
        if(selMode != selMode_NoSelect) {
            selection(startSelDate, endSelDate, true, false)
            selection(startSelDate, endSelDate, false, (selMode == selMode_Select))
        }

        selMode = selMode_NoSelect;
        startSelBox = null;
        endSelBox = null;
        startSelDate = null;
        endSelDate = null;
    }

    function performSelection(box) {
        var prevEndSelBox = endSelBox;
        if(box && selMode != selMode_NoSelect)
            endSelBox = box;

        if(startSelBox && endSelBox && endSelBox != prevEndSelBox){
            var prevStartSelDate = startSelDate;
            var prevEndSelDate = endSelDate;

            var interval = getIntervalBetweenBoxes(startSelBox, endSelBox);

            startSelDate = interval[0];
            endSelDate = interval[1];

            if(!prevStartSelDate)
                prevStartSelDate = startSelDate;

            if(!prevEndSelDate)
                prevEndSelDate = endSelDate;

            if(prevStartSelDate < startSelDate)
                selection(prevStartSelDate, startSelDate, true, false);

            if(intervalCtrl.endSelDate < prevEndSelDate)
                selection(endSelDate, prevEndSelDate, true, false);

            selection(startSelDate, endSelDate, true, true);
        }
    }

    function getIntervalBetweenBoxes(box1, box2) {
        var box1_firstDay = getFirstDate(box1);
        var box1_lastDay = getLastDate(box1);

        var box2_firstDay = getFirstDate(box2);
        var box2_lastDay = getLastDate(box2);

        if( box1.boxtype == boxType_YearBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear())
            return [box1_firstDay, box1_lastDay];

        if( box2.boxtype == boxType_YearBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear())
            return [box2_firstDay, box2_lastDay];

        if( box1.boxtype == boxType_MonthBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear() && box1_firstDay.getMonth() == box2_firstDay.getMonth())
            return [box1_firstDay, box1_lastDay];

        if( box2.boxtype == boxType_MonthBox && box1_firstDay.getFullYear() == box2_firstDay.getFullYear() && box1_firstDay.getMonth() == box2_firstDay.getMonth())
            return [box2_firstDay, box2_lastDay];

        return (box1_firstDay < box2_firstDay) ? [box1_firstDay, box2_lastDay] : [box2_firstDay, box1_lastDay];
    }

    function getFirstDate(box) {
        switch(box.boxtype) {
            case boxType_DayBox:
                return box.day;
            case boxType_MonthBox:
                return new Date(box.month.getFullYear(), box.month.getMonth(), 1)
            case boxType_YearBox:
                return new Date(box.year.getFullYear(), 0, 1)
        }

        console.log("Error. getFirstDate(). Unsupported item type"); null = 1;
        return null;
    }

    function getLastDate(box) {
        switch(box.boxtype) {
            case boxType_DayBox:
                return box.day;
            case boxType_MonthBox: {
                var year = box.month.getFullYear();
                var month = box.month.getMonth();
                return new Date(year, month, 32 - new Date(year, month, 32).getDate());
            }
            case boxType_YearBox:
                return new Date(box.year.getFullYear(), 11, 31);
        }

        console.log("Error. getLastDate(). Unsupported item type"); null = 1;
        return null;
    }

    function selection(from, to, is_tmp_selection, is_select)
    {
        if(yearsList.children.length == 0)
            return;

        var firstYear = getFirstYear();
        var lastYear = firstYear + yearsList.children.length - 1;

        for(var y = firstYear; y <= lastYear; y++) {
            if(!(from.getFullYear() <= y && y <= to.getFullYear()))
                continue;

            var yearRow = getYearRow(y);
            var monthesColumn = yearRow.children[1];

            var checkYearSelected = false;

            for(var m = 0; m < 12; m++ ) {
                var monthRow = monthesColumn.children[m];
                var daysRepeater = monthRow.children[monthRow.children.length-1];

                var chekMonthSelected = false;

                for(var d = 1; d <= daysRepeater.model; d++) {
                    var dt = new Date(y, m, d);
                    if(from <= dt && dt <= to) {
                        chekMonthSelected = true;

                        var dayBox = monthRow.children[d];
                        if(is_tmp_selection) {
                            if(selMode == selMode_Select)
                                dayBox.tempSelected = is_select;
                            else
                                dayBox.tempUnselected = is_select;
                        }
                        else
                            dayBox.selected = is_select;
                    }
                }

                if(chekMonthSelected) {
                    checkYearSelected = true;

                    var monthBox = monthRow.children[0];
                    var selectedCnt = 0;

                    for(var d = 1; d <= daysRepeater.model; d++) {
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

            if(checkYearSelected) {
                var unSelectedCnt = 0;
                var fullSelectedCnt = 0;

                for(var m = 0; m < 12; m++ ) {
                    var monthRow = monthesColumn.children[m];
                    var monthBox = monthRow.children[0];

                    if(monthBox.selected == monthBox._select_Unselected)
                        unSelectedCnt++;
                    else if(monthBox.selected == monthBox._select_FullSelected)
                        fullSelectedCnt++;
                }

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
}