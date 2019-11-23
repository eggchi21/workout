$(function(){
  $(window).bind("load", function(){
    if(document.URL.match(/diaries$/)) {
var planKcal = gon.plan_kcal
const ids = gon.ids ;
const dates = gon.dates;
const kcals = gon.kcals;
var firstDate = new Date(dates[0])
var lastDate = new Date(dates.slice(-1)[0])
var termDate = (lastDate - firstDate)/ 1000 / 60 / 60 / 24 + 1
// Themes begin
am4core.useTheme(am4themes_material);
am4core.useTheme(am4themes_animated);

// Themes end

var chart = am4core.create("chartdiv", am4charts.XYChart);
chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
chart.data = [];
for (var j = 0; j< kcals.length; j++){
  for (var i = 0; i < termDate; i++) {
    var newDate = new Date(firstDate)
    newDate.setDate(newDate.getDate() + i); //初日からi日分たす
    if ((new Date(dates[j])) - (newDate) == 0){
      kcal = kcals[j]
      id = ids[j]
      chart.data.push({
          date: newDate,
          kcal: kcal,
          id: id
      });
    }
  }
}
//未来分のダミーデータを作成(グラフ移動のスムーズ性向上)
for (var i = 1; i < 6; i++) {
  var newDate = new Date(lastDate)
  newDate.setDate(newDate.getDate() + i); //初日からi日分たす
    chart.data.push({
        date: newDate,
        kcal: 0
    });
}
//過去分のダミーデータを作成(グラフ移動のスムーズ性向上)
for (var i = 1; i < 6; i++) {
  var newDate = new Date(firstDate)
  newDate.setDate(newDate.getDate() - i); //初日からi日分たす
    chart.data.push({
        date: newDate,
        kcal: 0
    });
}
chart.dateFormatter.inputDateFormat = "YYYY/MM/dd";
chart.zoomOutButton.disabled = true;

var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
dateAxis.renderer.grid.template.strokeOpacity = 0;
dateAxis.renderer.minGridDistance = 10;
dateAxis.dateFormats.setKey("month", "m");
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
axisRange.label.text = "目標" + planKcal + "kcal";
axisRange.label.align = "right";
axisRange.label.verticalCenter = "bottom";
axisRange.label.fillOpacity = 0.8;

valueAxis.renderer.gridContainer.zIndex = 1;



var series = chart.series.push(new am4charts.ColumnSeries);
series.dataFields.valueY = "kcal";
series.dataFields.dateX = "date";
series.tooltipText = "{valueY.value}"+"kcal";
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
columnTemplate.url =`/diaries/{id.urlEncode()}/edit`;

columnTemplate.adapter.add("fill", function (fill, target) {
    var dataItem = target.dataItem;
    if (dataItem.valueY > planKcal) {
        return chart.colors.getIndex(0);
    }
    else {
        return am4core.color("#1253A4");
    }
})

var cursor = new am4charts.XYCursor();
cursor.behavior = "panX";
chart.cursor = cursor;
cursor.lineX.disabled = true;

var fiveBeforeDate = new Date(lastDate).setDate(new Date(lastDate).getDate() - 5)
var sixAfterDate = new Date(lastDate).setDate(new Date(lastDate).getDate() + 6)

chart.events.on("datavalidated", function () {
    dateAxis.zoomToDates(fiveBeforeDate, sixAfterDate , false, true);
});

var middleLine = chart.plotContainer.createChild(am4core.Line);
middleLine.strokeOpacity = 1;
middleLine.stroke = am4core.color("#000000");
middleLine.strokeDasharray = "2,2";
middleLine.align = "center";
middleLine.zIndex = 1;
middleLine.adapter.add("y2", function (y2, target) {
    return target.parent.pixelHeight;
})

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