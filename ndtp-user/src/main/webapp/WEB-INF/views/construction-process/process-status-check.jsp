<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript" src="/externlib/amchart/core.js"></script>
<script type="text/javascript" src="/externlib/amchart/charts.js"></script>
<script type="text/javascript" src="/externlib/amchart/themes/animated.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="processStatusCheckDialog" title="공정 현황 조회" class="basicTable" style="display: none;">
    <div id="chartdiv"></div>
</div>


<script>
    am4core.ready(function() {

// Themes begin
        am4core.useTheme(am4themes_animated);
// Themes end



        var chart = am4core.create("chartdiv", am4charts.XYChart);

        var data = [];
        var open = 100;
        var close = 120;

        var names = ["Raina",
            "Demarcus",
            "Carlo",
            "Jacinda",
            "Richie",
            "Antony",
            "Amada",
            "Idalia",
            "Janella",
            "Marla",
            "Curtis",
            "Shellie",
            "Meggan",
            "Nathanael",
            "Jannette",
            "Tyrell",
            "Sheena",
            "Maranda",
            "Briana",
            "Rosa",
            "Rosanne",
            "Herman",
            "Wayne",
            "Shamika",
            "Suk",
            "Clair",
            "Olivia",
            "Hans",
            "Glennie",
        ];

        for (var i = 0; i < names.length; i++) {
            open += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 5);
            close = open + Math.round(Math.random() * 10) + 3;
            data.push({ category: names[i], open: open, close: close });
        }

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

        var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
        valueAxis.tooltip.disabled = true;
        valueAxis.renderer.ticks.template.disabled = true;
        valueAxis.renderer.axisFills.template.disabled = true;

        var series = chart.series.push(new am4charts.ColumnSeries());
        series.dataFields.categoryY = "category";
        series.dataFields.openValueX = "open";
        series.dataFields.valueX = "close";
        series.tooltipText = "open: {openValueX.value} close: {valueX.value}";
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

    }); // end am4core.ready()


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