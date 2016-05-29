function addFocusCharts(_char) {
  function rangesEqual(range1, range2) {
    if (!range1 && !range2) {
      return true;
    }
    else if (!range1 || !range2) {
      return false;
    }
    else if (range1.length === 0 && range2.length === 0) {
      return true;
    }
    else if (range1[0].valueOf() === range2[0].valueOf() &&
      range1[1].valueOf() === range2[1].valueOf()) {
      return true;
    }
    return false;
  }

  _char.focusCharts = function (chartlist) {
    if (!arguments.length) {
      return this._focusCharts;
    }
    this._focusCharts = chartlist; // only needed to support the getter above
    this.on('filtered', function (range_chart) {
      if (!range_chart.filter()) {
        dc.events.trigger(function () {
          chartlist.forEach(function(focus_chart) {
            focus_chart.x().domain(focus_chart.xOriginalDomain());
          });
        });
      } else chartlist.forEach(function(focus_chart) {
        if (!rangesEqual(range_chart.filter(), focus_chart.filter())) {
          dc.events.trigger(function () {
            focus_chart.focus(range_chart.filter());
          });
        }
      });
    });
    return this;
  };
}