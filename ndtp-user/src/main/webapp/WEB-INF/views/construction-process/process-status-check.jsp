<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript" src="/externlib/amchart/core.js"></script>
<script type="text/javascript" src="/externlib/amchart/charts.js"></script>
<script type="text/javascript" src="/externlib/amchart/themes/animated.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="processStatusCheckDialog" title="공정 현황 조회" class="basicTable" style="display: none;">
    <div id="chartdiv" style=""></div>
</div>


<script>
    am4core.ready(function() {

// Themes begin
        am4core.useTheme(am4themes_animated);
// Themes end

        var chart = am4core.create("chartdiv", am4charts.XYChart);
        chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

        chart.paddingRight = 30;
        chart.dateFormatter.inputDateFormat = "yyyy-MM-dd HH:mm";
        // chart.periodChangeDateFormats

        var colorSet = new am4core.ColorSet();
        colorSet.saturation = 0.4;

        var names = ["교량공(주교량)",
            "교량공(교면방수)",
            "조경공사"
        ];

        chart.data = [{
                name: names[0],
                description: "P3 ~ P4",
                fromDate: "2020-01-01",
                toDate: "2020-01-12",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[0],
                description: "P4 ~ P5",
                fromDate: "2020-01-12",
                toDate: "2020-02-18",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[0],
                description: "P5 ~ P6",
                fromDate: "2020-02-18",
                toDate: "2020-03-06",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[0],
                description: "P6 ~ P7",
                fromDate: "2020-03-06",
                toDate: "2020-03-21",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[0],
                description: "P7 ~ P8",
                fromDate: "2020-03-21",
                toDate: "2020-04-09",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[0],
                description: "P8 ~ P9",
                fromDate: "2020-04-09",
                toDate: "2020-04-24",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[0],
                description: "프리캐스트 패널",
                fromDate: "2020-04-24",
                toDate: "2020-05-24",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[0],
                description: "슬래브",
                fromDate: "2020-05-24",
                toDate: "2020-07-24",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[1],
                description: "상층부 (도막방수)",
                fromDate: "2020-07-24",
                toDate: "2020-08-12",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[2],
                description: "플랜터",
                fromDate: "2020-08-12",
                toDate: "2020-09-27",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[2],
                description: "식재기반 조성",
                fromDate: "2020-09-27",
                toDate: "2020-11-12",
                color: colorSet.getIndex(4).brighten(0)
            },{
                name: names[2],
                description: "식재",
                fromDate: "2020-11-12",
                toDate: "2020-12-21",
                color: colorSet.getIndex(4).brighten(0.4)
            },{
                name: names[2],
                description: "포장 및 시설물",
                fromDate: "2020-12-21",
                toDate: "2020-12-31",
                color: colorSet.getIndex(4).brighten(0)
            }
        ];

        var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
        categoryAxis.dataFields.category = "name";
        categoryAxis.renderer.grid.template.location = 0;
        categoryAxis.renderer.inversed = true;

        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        dateAxis.dateFormatter.dateFormat = "yyyy-MM-dd";
        dateAxis.dateFormats.setKey("year", "yyyy");
        dateAxis.dateFormats.setKey("month", "MM");
        dateAxis.periodChangeDateFormats.setKey("month", "[bold]yyyy[/].MM");
        dateAxis.dateFormats.setKey("week", "MM.dd");
        dateAxis.periodChangeDateFormats.setKey("week", "[bold]MM[/].dd");
        dateAxis.dateFormats.setKey("day", "MM.dd");
        dateAxis.periodChangeDateFormats.setKey("day", "[bold]MM[/].dd");

        dateAxis.renderer.minGridDistance = 70;
        dateAxis.baseInterval = { count: 3, timeUnit: "day" };
        // dateAxis.max = new Date(2021, 0, 31, 24, 0, 0, 0).getTime();
        dateAxis.strictMinMax = true;
        dateAxis.renderer.tooltipLocation = 0;

        var series1 = chart.series.push(new am4charts.ColumnSeries());
        series1.columns.template.width = am4core.percent(80);
        series1.columns.template.tooltipText = "{description}: {openDateX} - {dateX}";

        series1.dataFields.openDateX = "fromDate";
        series1.dataFields.dateX = "toDate";
        series1.dataFields.categoryY = "name";
        series1.columns.template.propertyFields.fill = "color"; // get color from data
        series1.columns.template.propertyFields.stroke = "color";
        series1.columns.template.strokeOpacity = 1;

        series1.columns.template.events.on("hit", function(ev) {
            b=ev.target;
            console.log("clicked on ", ev.target);
            // b.dataItem.dataContext
        }, this);

        chart.scrollbarX = new am4core.Scrollbar();

    }); // end am4core.ready()







    /*am4core.ready(function() {

// Themes begin
        am4core.useTheme(am4themes_animated);
// Themes end



        var chart = am4core.create("chartdiv", am4charts.XYChart);

        var data = [];
        // var open = 100;
        // var close = 120;

        var names = ["교량공(주교량)",
            "교량공(교면방수)",
            "조경공사(주교량)"
        ];

        // for (var i = 0; i < names.length; i++) {
        //     open += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 5);
        //     close = open + Math.round(Math.random() * 10) + 3;
        //     data.push({ category: names[i], open: open, close: close });
        // }
        data.push({category: names[0], open: new Date(2020, 0, 1), close: new Date(2020, 0, 12)});
        data.push({category: names[0], open: new Date(2020, 0, 12), close: new Date(2020, 1, 18)});
        data.push({category: names[0], open: new Date(2020, 1, 18), close: new Date(2020, 2, 6)});
        data.push({category: names[0], open: new Date(2020, 2, 6), close: new Date(2020, 2, 21)});
        data.push({category: names[0], open: new Date(2020, 2, 21), close: new Date(2020, 3, 9)});
        data.push({category: names[0], open: new Date(2020, 3, 9), close: new Date(2020, 3, 24)});
        data.push({category: names[0], open: new Date(2020, 3, 24), close: new Date(2020, 4, 24)});
        data.push({category: names[0], open: new Date(2020, 4, 24), close: new Date(2020, 6, 24)});

        data.push({category: names[1], open: new Date(2020, 6, 24), close: new Date(2020, 7, 12)});

        data.push({category: names[2], open: new Date(2020, 7, 12), close: new Date(2020, 8, 27)});
        data.push({category: names[2], open: new Date(2020, 8, 27), close: new Date(2020, 10, 12)});

        // data.push({category: names[0], open:20, close:30});
        // data.push({category: names[1], open:30, close:40});
        // data.push({category: names[1], open:40, close:50});
        // data.push({category: names[1], open:50, close:60});

        chart.data = data;

        var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
        categoryAxis.renderer.grid.template.location = 0;
        categoryAxis.renderer.ticks.template.disabled = true;
        categoryAxis.renderer.axisFills.template.disabled = true;
        categoryAxis.dataFields.category = "category";
        categoryAxis.renderer.minGridDistance = 15;
        categoryAxis.renderer.inversed = true;
        categoryAxis.renderer.inside = true;
        categoryAxis.renderer.grid.template.location = 0.5;
        categoryAxis.renderer.grid.template.strokeDasharray = "1,3";

        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        // dateAxis.tooltip.disabled = true;
        // dateAxis.renderer.ticks.template.disabled = true;
        // dateAxis.renderer.axisFills.template.disabled = true;
        dateAxis.min = new Date(2019, 10, 1);

        var series = chart.series.push(new am4charts.ColumnSeries());
        series.dataFields.categoryY = "category";
        series.dataFields.openDateX = "open";
        series.dataFields.dateX = "close";
        // series.dataFields.openValueX = "open";
        // series.dataFields.valueX = "close";
        series.tooltipText = "open: {openDateX.value} close: {dateX.value}";
        series.sequencedInterpolation = true;
        series.fillOpacity = 0;
        series.strokeOpacity = 1;
        series.columns.template.height = 0.01;
        series.tooltip.pointerOrientation = "vertical";

        var openBullet = series.bullets.create(am4charts.CircleBullet);
        openBullet.locationX = 1;

        var closeBullet = series.bullets.create(am4charts.CircleBullet);

        closeBullet.fill = chart.colors.getIndex(4);
        closeBullet.stroke = closeBullet.fill;

        chart.cursor = new am4charts.XYCursor();
        chart.cursor.behavior = "zoomY";

        chart.scrollbarX = new am4core.Scrollbar();
        chart.scrollbarY = new am4core.Scrollbar();
        debugger;
    }); // end am4core.ready()
*/

</script>

<style>
    #chartdiv {
        width: 100%;
        height: 500px;
    }

    #processStatusCheckDialog ul.listDrop li ul li{
        display: inline-block;;
        width:49%;
    }

    #processStatusCheckDialog ul.listDrop li ul li input {
        width: 300px;
    }

    table.type02 {
        border-collapse: separate;
        border-spacing: 0;
        text-align: left;
        line-height: 1.5;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        margin : 20px 10px;
    }
    table.type02 th {
        width: 150px;
        padding: 10px;
        font-weight: bold;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
        border-top: 1px solid #fff;
        border-left: 1px solid #fff;
        background: #eee;
    }
    table.type02 td {
        width: 350px;
        padding: 10px;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }
</style>