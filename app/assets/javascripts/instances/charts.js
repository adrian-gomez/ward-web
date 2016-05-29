function buildInstanceCharts(instanceId, readingsPath) {
  var cpuChart = dc.lineChart('#cpu-usage-chart-' + instanceId);
  var diskChart = dc.lineChart('#disk-usage-chart-' + instanceId);
  var volumeChart = dc.barChart('#scan-chart-' + instanceId);
  var nasdaqTable = dc.dataTable('#data-table-' + instanceId);
  addFocusCharts(volumeChart);

  d3.json(readingsPath, function (data) {
    var dateFormat = d3.time.format('%Y-%m-%dT%H:%M:%SZ');
    var numberFormat = d3.format('.2f');
    var minDate, maxDate;

    data.forEach(function (d) {
      d.dd = dateFormat.parse(d.created_at);
      if (!minDate || d.dd < minDate) { minDate = d.dd; }
      if (!maxDate || d.dd > maxDate) { maxDate = d.dd; }
    });

    var ndx = crossfilter(data);

    var dateDimension = ndx.dimension(function (d) {
      return d.dd;
    });

    var dateCpuUsageGroup = dateDimension.group().reduceSum(function (d) {
      return d.data.cpu_usage;
    });

    var dateDiskUsageGroup = dateDimension.group().reduceSum(function (d) {
      return d.data.disk_usage;
    });

    cpuChart
      .renderArea(true)
      .width(990)
      .height(200)
      .transitionDuration(1000)
      .margins({top: 30, right: 50, bottom: 25, left: 40})
      .dimension(dateDimension)
      .x(d3.time.scale().domain([minDate, maxDate]))
      .colors(['red'])
      .round(d3.time.seconds.round)
      .xUnits(d3.time.seconds)
      .elasticY(true)
      .renderHorizontalGridLines(true)
      .legend(dc.legend().x(800).y(10).itemHeight(13).gap(5))
      .brushOn(false)
      .group(dateCpuUsageGroup, 'CPU Usage')
      .title(function (d) {
        var value = d.data.value;

        if (isNaN(value)) { value = 0; }

        return dateFormat(d.data.key) + ': ' + numberFormat(value);
      });

    diskChart
      .renderArea(true)
      .width(990)
      .height(200)
      .transitionDuration(1000)
      .margins({top: 30, right: 50, bottom: 25, left: 40})
      .dimension(dateDimension)
      .x(d3.time.scale().domain([minDate, maxDate]))
      .colors(['green'])
      .round(d3.time.seconds.round)
      .xUnits(d3.time.seconds)
      .elasticY(true)
      .renderHorizontalGridLines(true)
      .legend(dc.legend().x(800).y(10).itemHeight(13).gap(5))
      .brushOn(false)
      .group(dateDiskUsageGroup, 'Disk Usage')
      .title(function (d) {
        var value = d.data.value;

        if (isNaN(value)) { value = 0; }

        return dateFormat(d.data.key) + ': ' + numberFormat(value);
      });

    volumeChart
      .width(990)
      .height(40)
      .margins({top: 0, right: 50, bottom: 20, left: 40})
      .dimension(dateDimension)
      .group(dateDiskUsageGroup)
      .centerBar(true)
      .gap(1)
      .x(d3.time.scale().domain([minDate, maxDate]))
      .round(d3.time.seconds.round)
      .xUnits(d3.time.minutes)
      .focusCharts([cpuChart, diskChart]);

    nasdaqTable
      .dimension(dateDimension)
      .group(function (d) {
        return d.dd;
      })
      .size(10)
      .columns([
        function(d) {
          return '<a href="/instances/' + d.instance_id.$oid + '/readings/' + d._id.$oid + '">' + d._id.$oid + '</a>';
        },
        function(d) {
          return d.dd;
        },
        function(d) {
          return numberFormat(d.data.cpu_usage);
        },
        function(d) {
          return numberFormat(d.data.disk_usage);
        }
      ])
      .sortBy(function (d) {
        return d.dd;
      })
      .order(d3.descending);

    nasdaqTable.renderlet(function(chart) {
      chart.selectAll('.dc-table-group').remove();
    });

    dc.renderAll();
  });
}