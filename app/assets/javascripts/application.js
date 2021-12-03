//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require dataTables/jquery.dataTables

function save_dot_goal(hunter_id,goal_id){
    var id_text=hunter_id+"_"+goal_id;
    //alert(id_text); // 1
    var val= $("#"+id_text).val();
    //alert(val);

    $.get("/admin_modules/dots/assing_goals?goal_id="+goal_id+"&goal_value="+val, function(result) {
      if (result == false)
      {
        //alert("Nice try. Now do it again using correct password!");
      }else if (result == true){
        alert("Nice");
        location.reload();
      }
    });
}

function save_dot_goal(hunter_id,goal_id){
    var id_text=hunter_id+"_"+goal_id;
    //alert(id_text); // 1
    var val= $("#"+id_text).val();
    //alert(val);

    $.get("/admin_modules/dots/assing_goals?goal_id="+goal_id+"&goal_value="+val, function(result) {
      if (result == false)
      {
        //alert("Nice try. Now do it again using correct password!");
      }else if (result == true){
        alert("Nice");
        location.reload();
      }
    });
}