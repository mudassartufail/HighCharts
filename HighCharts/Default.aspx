<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HighCharts.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HighCharts in ASP.NET / C#</title>
    <!-- Import jQuery Library -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.2.min.js"></script>
    <!-- Import HighCharts Library -->
    <script type="text/javascript" src="https://code.highcharts.com/highcharts.js"></script>
    <!-- Import HighCharts Export Library -->
    <script type="text/javascript" src="https://code.highcharts.com/modules/exporting.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="barChartDiv" style="width: 600px; height: 500px;"></div>
        
        <div id="pieChartDiv" style="width: 600px; height: 300px;"></div>
    </div>
    <script type="text/javascript">
        $.ajax({
            type: "POST",
            url: "Default.aspx/GetPopulation", //WebMethod to be called
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,   //execute script synchronously
            success: function (data) {
                //parsing json data
                var parsed = $.parseJSON(data.d);
                var population = [];
                //get each parsed json element and serialized it
                $.each(parsed, function (i, jsondata) {
                    for (var i in jsondata) {
                        var serial = new Array(i, parseFloat(jsondata[i])); //serialized array with province and population values
                        population.push(serial); //build an array to be bind with values for HighCharts
                    }
                });

                //Calling chart functions with population data
                DrawBarChart(population);
                DrawPieChart(population);
            },
            failure: function (response) {
                var r = jQuery.parseJSON(response.responseText);
                alert("Message: " + r.Message);
                alert("StackTrace: " + r.StackTrace);
                alert("ExceptionType: " + r.ExceptionType);
            }
        });


        //Function to draw Pie Chart
        function DrawPieChart(population) {
            var chart;
            $(document).ready(function () {
                chart = new Highcharts.Chart({
                    chart: {
                        renderTo: 'pieChartDiv',   //Target Div for chart
                        defaultSeriesType: 'pie'
                    },
                    title: {
                        text: 'Population Province wise, Census 1998'
                    },
                    series: [{
                        data: population   //Binding json data to chart
                    }]
                });
            });
        }

        //Function to draw Bar Chart
        function DrawBarChart(population) {
            $('#barChartDiv').highcharts({
                chart: { type: 'column' },  //Bar Chart
                title: { text: 'Population'},
                subtitle: { text: 'Province wise according to Census 1998' },
                xAxis: { type: 'category', labels: { rotation: -90, style: { fontSize: '16px', fontFamily: 'Verdana, sans-serif' } } },
                yAxis: { min: 0, title: { text: 'Percentage %' } },
                legend: { enabled: true },
                tooltip: { pointFormat: 'Percentage: <b>{point.y:.2f}</b> %' },
                series: [{
                    name: 'Population',
                    data: population,  //Binding data
                    dataLabels: {
                        enabled: true, rotation: -0, color: '#FFFFFF', align: 'right', format: '{point.y:.1f}', y: 10,
                        style: { fontSize: '16px', fontFamily: 'Verdana, sans-serif' }
                    }
                }]
            });
        }
    </script>
    </form>
</body>
</html>
