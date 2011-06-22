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
    
    hider("#all", "#define_customers");
    hider("#no_limit", "#limit");
    hider("#usage", "#discount_template_use_limit");
    hider("#usage", "#s");
    hider("#anytime", "#valid_time");
    
    calenderfy("#starts_at", "#discount_template_starts_at");
    calenderfy("#ends_at", "#discount_template_ends_at");
    calenderfy("#order_before", "#discount_template_order_placed_before");
    calenderfy("#order_after", "#discount_template_order_placed_after");
    
    $(".hide_me").hide();
    
  }
);