$(function(){
  $(window).bind("load", function(){
    if(document.URL.match(/diaries$/)) {
var planKcal = gon.plan_kcal
const dates = gon.dates;
console.log(gon.kcals)
var firstDate = new Date(dates[0])
var lastDate = new Date(dates.slice(-1)[0])
var termDate = (lastDate - firstDate)/ 1000 / 60 / 60 / 24 + 1
// Themes begin
am4core.useTheme(am4themes_material);
am4core.useTheme(am4themes_animated);

// Themes end

var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

chart.data = [{
    "date": "2019-11-01",
    "steps": 4561
}, {
    "date": "2019-11-02",
    "steps": 5687
}, {
    "date": "2019-11-03",
    "steps": 6348
}, {
    "date": "2019-11-04",
    "steps": 4878
}, {
    "date": "2019-11-05",
    "steps": 9867
}, {
    "date": "2019-11-06",
    "steps": 7561
}, {
    "date": "2019-11-07",
    "steps": 1287
}, {
    "date": "2019-11-08",
    "steps": 3298
}, {
    "date": "2019-11-09",
    "steps": 5697
}, {
    "date": "2019-11-10",
    "steps": 4878
}, {
    "date": "2019-11-11",
    "steps": 8788
}, {
    "date": "2019-11-12",
    "steps": 9560
}, {
    "date": "2019-11-13",
    "steps": 11687
}, {
    "date": "2019-11-14",
    "steps": 587
}, {
    "date": "2019-11-15",
    "steps": 978
}, {
    "date": "2019-11-16",
    "steps": 3987
}, {
    "date": "2019-11-17",
    "steps": 5898
}, {
    "date": "2019-11-18",
    "steps": 9878
}, {
    "date": "2019-11-19",
    "steps": 13687
}, {
    "date": "2019-11-20",
    "steps": 6789
}, {
    "date": "2019-11-21",
    "steps": 4531
}, {
    "date": "2019-11-22",
    "steps": 5856
}, {
    "date": "2019-11-23",
    "steps": 5737
}, {
    "date": "2019-11-24",
    "steps": 998
}, {
    "date": "2019-11-25",
    "steps": 164
}, {
    "date": "2019-11-26",
    "steps": 7878
}, {
    "date": "2019-11-27",
    "steps": 6845
}, {
    "date": "2019-11-28",
    "steps": 4659
}, {
    "date": "2019-11-29",
    "steps": 7892
}, {
    "date": "2019-11-30",
    "steps": 7362
}, {
    "date": gon.diary ,
    "steps": 3268
}];

chart.dateFormatter.inputDateFormat = "YYYY-MM-dd";
chart.zoomOutButton.disabled = true;

var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.grid.template.strokeOpacity = 0;
dateAxis.renderer.minGridDistance = 10;
dateAxis.dateFormats.setKey("day", "d");
dateAxis.tooltip.hiddenState.properties.opacity = 1;
dateAxis.tooltip.hiddenState.properties.visible = true;


dateAxis.tooltip.adapter.add("x", function (x, target) {
    return am4core.utils.spritePointToSvg({ x: chart.plotContainer.pixelX, y: 0 }, chart.plotContainer).x + chart.plotContainer.pixelWidth / 2;
})

var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
valueAxis.renderer.inside = true;
valueAxis.renderer.labels.template.fillOpacity = 0.3;
valueAxis.renderer.grid.template.strokeOpacity = 0;
valueAxis.min = 0;
valueAxis.cursorTooltipEnabled = false;

// goal guides
var axisRange = valueAxis.axisRanges.create();
axisRange.value = planKcal;
axisRange.grid.strokeOpacity = 0.1;
axisRange.label.text = planKcal + "kcal";
axisRange.label.align = "right";
axisRange.label.verticalCenter = "bottom";
axisRange.label.fillOpacity = 0.8;

valueAxis.renderer.gridContainer.zIndex = 1;



var series = chart.series.push(new am4charts.ColumnSeries);
series.dataFields.valueY = "steps";
series.dataFields.dateX = "date";
series.tooltipText = "{valueY.value}";
series.tooltip.pointerOrientation = "vertical";
series.tooltip.hiddenState.properties.opacity = 1;
series.tooltip.hiddenState.properties.visible = true;
series.tooltip.adapter.add("x", function (x, target) {
    return am4core.utils.spritePointToSvg({ x: chart.plotContainer.pixelX, y: 0 }, chart.plotContainer).x + chart.plotContainer.pixelWidth / 2;
})

var columnTemplate = series.columns.template;
columnTemplate.width = 30;
columnTemplate.column.cornerRadiusTopLeft = 20;
columnTemplate.column.cornerRadiusTopRight = 20;
columnTemplate.strokeOpacity = 0;

columnTemplate.adapter.add("fill", function (fill, target) {
    var dataItem = target.dataItem;
    if (dataItem.valueY > planKcal) {
        return chart.colors.getIndex(0);
    }
    else {
        return am4core.color("#a8b3b7");
    }
})

var cursor = new am4charts.XYCursor();
cursor.behavior = "panX";
chart.cursor = cursor;
cursor.lineX.disabled = true;

var tenBeforeDate = new Date(lastDate).setDate(new Date(lastDate).getDate() - 10)
chart.events.on("datavalidated", function () {
    dateAxis.zoomToDates(tenBeforeDate, lastDate.setDate(lastDate.getDate() + 1), false, true);
});


cursor.events.on("cursorpositionchanged", updateTooltip);
dateAxis.events.on("datarangechanged", updateTooltip);

function updateTooltip() {
    dateAxis.showTooltipAtPosition(0.5);
    series.showTooltipAtPosition(0.5, 0);
    series.tooltip.validate(); // otherwise will show other columns values for a second
}

    }
  })
})