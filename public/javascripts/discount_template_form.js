$(document).ready(
  function(){
    toglify("#all", "#discount_customer_criteria");
    toglify("#no_limit", "#limit");
    toglify("#usage", "#discount_use_limit");
    
    function toglify(link,input){
      $(link).click(function(){
        $(link).toggle();
        $(input).toggle();
      });
    }
    
    $("#discount_starts_at").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#starts_at").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    
    $("#starts_at").click(function(){
      $("#discount_starts_at").datepicker('show');
    });
    
    $("#discount_ends_at").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#ends_at").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    $("#ends_at").click(function(){
      $("#discount_ends_at").datepicker('show');
    });
    
  }
);