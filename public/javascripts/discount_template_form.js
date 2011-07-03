function hider(link,input){
  $(link).click(function(){
    $(link).hide();
    $(input).show();
  });
}

function slider(link,input){
  $(link).click(function(){
    $(input).slideToggle();  
  });
}

//When the link is click, show
// a jquery-ui calendar for the
// given input
function calenderfy(link, input){
  $(input).datepicker({ 
    minDate: 0,
    onSelect: function(date) {
                $(link).html(date)
    },
    dateFormat: 'd M yy'
  });


  $(link).click(function(){
    $(input).datepicker('show');
  });
}

$(document).ready(
  function(){
    
    hider("#valid_time_link", "#valid_time");
    hider("#spend_link", "#spend");
    $(".hide_me").hide();
    
  }
);