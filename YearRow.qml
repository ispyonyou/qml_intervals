import QtQuick 1.1

Row{
    id : yearRow

    property date year
    property int boxtype : intervalCtrl.boxType_YearRow

    spacing : 1

    Behavior on y { NumberAnimation {} }
 
    YearBox {
        id : yearBox
        year : yearRow.year
    }

    function getMonthDate(m) {
        return new Date(year.getFullYear(), m - 1, 1);
    }

    Column {
        spacing : 1
        property int boxtype : intervalCtrl.boxType_MonthesCol
        property date year : yearRow.year;

        MonthRow { month : getMonthDate(1) }
        MonthRow { month : getMonthDate(2) }
        MonthRow { month : getMonthDate(3) }
        MonthRow { month : getMonthDate(4) }
        MonthRow { month : getMonthDate(5) }
        MonthRow { month : getMonthDate(6) }
        MonthRow { month : getMonthDate(7) }
        MonthRow { month : getMonthDate(8) }
        MonthRow { month : getMonthDate(9) }
        MonthRow { month : getMonthDate(10) }
        MonthRow { month : getMonthDate(11) }
        MonthRow { month : getMonthDate(12) }
    }
}