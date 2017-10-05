$(function () {
  path = window.location.pathname;
  $("nav li a[href='"+path+"']").closest('li').addClass('active');
});

$(function () {
  $('#datetimepicker1').datetimepicker({
    format: "YYYY-MM-DD"
  });
});
