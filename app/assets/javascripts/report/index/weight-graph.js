$(function(){
  $(window).bind("load", function(){
    if(document.URL.match(/\/users\/\d\/reports$/)) {
      am4core.ready(function() {

      // Themes begin
      am4core.useTheme(am4themes_dataviz);
      am4core.useTheme(am4themes_animated);
      // Themes end

      // Create chart instance
      var chart = am4core.create("chartdiv", am4charts.XYChart);
      const weights = gon.weights;
      const dates = gon.dates;
      const ids = gon.ids ;
      var user_id = gon.user_id;

      var firstDate = new Date(dates[0])
      var lastDate = new Date(dates.slice(-1)[0])
      var termDate= (lastDate - firstDate)/ 1000 / 60 / 60 / 24 + 1

      // Add data
        chart.data = [];
        for (var j =0; j< weights.length; j++){
          for (var i = 0; i < termDate; i++) {
            var newDate = new Date(firstDate)
            newDate.setDate(newDate.getDate() + i); //初日からi日分たす
            if ((new Date(dates[j])) - (newDate)==0){
              weight = weights[j]
              id = ids[j]
              chart.data.push({
                  date: newDate,
                  weight: weight,
                  id: id
              });
            }
          }
        }

      // Set input format for the dates
      chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";

      // Create axes
      var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
      var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

      // Create series
      var series = chart.series.push(new am4charts.LineSeries());
      series.dataFields.valueY = "weight";
      series.dataFields.dateX = "date";
      series.tooltipText = "{weight}"
      series.strokeWidth = 2;
      series.minBulletDistance = 15;

      // Drop-shaped tooltips
      series.tooltip.background.cornerRadius = 20;
      series.tooltip.background.strokeOpacity = 0;
      series.tooltip.pointerOrientation = "vertical";
      series.tooltip.label.minWidth = 40;
      series.tooltip.label.minHeight = 40;
      series.tooltip.label.textAlign = "middle";
      series.tooltip.label.textValign = "middle";

      // Make bullets grow on hover
      var bullet = series.bullets.push(new am4charts.CircleBullet());
      bullet.circle.strokeWidth = 2;
      bullet.circle.radius = 10;
      bullet.circle.url =`/users/${user_id}/reports/{id.urlEncode()}`;
      bullet.circle.fill = am4core.color("#F26964");

      var bullethover = bullet.states.create("hover");
      bullethover.properties.scale = 1.3;

      // Make a panning cursor
      chart.cursor = new am4charts.XYCursor();
      chart.cursor.behavior = "panXY";
      chart.cursor.xAxis = dateAxis;
      chart.cursor.snapToSeries = series;

      // Create vertical scrollbar and place it before the value axis
      chart.scrollbarY = new am4core.Scrollbar();
      chart.scrollbarY.parent = chart.leftAxesContainer;
      chart.scrollbarY.toBack();

      // Create a horizontal scrollbar with previe and place it underneath the date axis
      chart.scrollbarX = new am4charts.XYChartScrollbar();
      chart.scrollbarX.series.push(series);
      chart.scrollbarX.parent = chart.bottomAxesContainer;

      chart.events.on("ready", function () {
        dateAxis.zoom({start:1-7/termDate, end:1});
      });

      }); // end am4core.ready()
    }
  })
})
