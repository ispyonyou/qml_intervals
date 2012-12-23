import Qt 4.7

Row{

    property date year
    property int boxtype: 11

    spacing: 1
 
    YearBox{
        year : parent.year
    }

    Column{
        spacing: 1
        property int boxtype: 12

        MonthRow{
            id: month0
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-01-01"
        }
        MonthRow{
            id: month1
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-02-01"
        }
        MonthRow{
            id: month2
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-03-01"
        }
        MonthRow{
            id: month3
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-04-01"
        }
        MonthRow{
            id: month4
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-05-01"
        }
        MonthRow{
            id: month5
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-06-01"
        }
        MonthRow{
            id: month6
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-07-01"
        }
        MonthRow{
            id: month7
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-08-01"
        }
        MonthRow{
            id: month8
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-09-01"
        }
        MonthRow{
            id: month9
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-10-01"
        }
        MonthRow{
            id: month10
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-11-01"
        }
        MonthRow{
            id: month11
            month : Qt.formatDate(parent.parent.year, "yyyy" ) + "-12-01"
        }

        Component.onCompleted:{console.log("on completed year - " + year)}
        Component.onDestruction:{console.log("on destruction year - " + year)}
    }

}