import QtQuick 1.1

Item
{
    id: yearsCol

    property bool isCompleted: false
    property Item animTarget: null

    signal add

    onChildrenChanged: 
    {
//        updatePositions();
    }

    Component.onCompleted: {
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

        console.log("updatePositions() ctrl.yearRows.length - " + intervalCtrl.yearRows.length)
        console.log("updatePositions() children.length - " + intervalCtrl.children.length)

        var minYear = 10000;
        for(var i = 0; i < yearsCol.children.length; i++ ) {
            if( yearsCol.children[i].year.getFullYear() < minYear )
                minYear = yearsCol.children[i].year.getFullYear();
        }

        yearsCol.height = 240 * yearsCol.children.length;

        for(var i = 0; i < yearsCol.children.length; i++ ) {
            console.log(yearsCol.children[i].year.getFullYear())
            yearsCol.children[i].y = 240 * ( yearsCol.children[i].year.getFullYear() - minYear);
        }

        animTarget = yearsCol.children[yearsCol.children.length-1];

        yearsCol.add();
    }

    function getFirstYear()
    {
        var minYear = 10000;
        for(var i = 0; i < yearsCol.children.length; i++ ) {
            if( yearsCol.children[i].year.getFullYear() < minYear )
                minYear = yearsCol.children[i].year.getFullYear();
        }

        return minYear;
    }

    function getYearRow(year)
    {
        for(var i = 0; i < yearsCol.children.length; i++ )
            if( yearsCol.children[i].year.getFullYear() == year )
                return yearsCol.children[i];
    }
}