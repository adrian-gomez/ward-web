$(function() {
  $('.instance-charts').each(function() {
    var $this = $(this);
    buildInstanceCharts($this.data('instanceId'), $this.data('readingsPath'));
  });
});
