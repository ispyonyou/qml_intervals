import QtQuick 1.1

Row{

    property date month
    property int boxtype: 13


    onMonthChanged:
    {
        monthRow.children[1].model = daysInMonth(month.getFullYear(), month.getMonth());
    }

    function daysInMonth(iYear, iMonth)
    {
        return 32 - new Date(iYear, iMonth, 32).getDate();
    }

    id: monthRow
    spacing: 1
 
    MonthBox{
        month : parent.month
    }
    Repeater {
        id: daysRepeater

        model: 3
        DayBox{
        }
        onItemAdded:
        {
            var d = new Date(month)
            d.setDate(index+1)

            item.day = d
        }
    }
}