//function to add a new row
function create_row() {
  document.getElementById("hidden").value++;
  var val = document.getElementById("hidden").value;
  $.ajax({
    type: "post",
    url: "/tasksheets/create_row",
    data: {key: val}
  }); 
}

//function to delete the row
function delete_row(num) { 
  $("#row_id_"+num).remove();
} 
 
//function to show the link "delete" after save 
function delete_link() {
  var val = document.getElementById("hidden").value;
  if (val>0)
  {
    for (var i=0;i<val;i++)
    {
      $("#fdelete_"+i).show();
    } 
  }
  $("#fdelete_"+val).hide(); 
}
 
function submit_for_approval(row_date, id, status) {
  //alert(status)
  $.ajax({
    type: "post",
    url: "/reports/submit_for_approval",
    data: {my_param: row_date, ids: id, status: status }
  });  
}

function accept_data(date, id) {
  //alert(date)
  //alert(id)
  $.ajax({
    type: "post",
    url: "/check_reports/accept_data",
    data: {my_param: date, ids: id}
  });  
} 

function reject_data(date, id) {
  //alert(date)
  //alert(id)
  $.ajax({
    type: "post",
    url: "/check_reports/reject_data",
    data: {my_param: date, ids: id}
  });  
} 
 
function reason_for_rejection(date, id) {
  //alert(date) 
  //alert(id)
  reason_value = document.getElementById("reason_"+date).value
  $.ajax({
    type: "post",
    url: "/check_reports/reason_for_rejection",
    data: {my_param: date, ids: id, value: reason_value }
  });
}
  
