$(document).ready(
  function(){
    toglify("#all", "#discount_template_customer_criteria");
    toglify("#no_limit", "#limit");
    toglify("#usage", "#discount_template_use_limit");
    
    function toglify(link,input){
      $(link).click(function(){
        $(link).toggle();
        $(input).toggle();
      });
    }
    
    $("#discount_template_starts_at").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#starts_at").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    
    $("#starts_at").click(function(){
      $("#discount_template_starts_at").datepicker('show');
    });
    
    $("#discount_template_ends_at").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#ends_at").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    $("#ends_at").click(function(){
      $("#discount_template_ends_at").datepicker('show');
    });
    
    $("#discount_template_order_placed_before").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#order_before").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    $("#order_before").click(function(){
      $("#discount_template_order_placed_before").datepicker('show');
    });
    
    $("#discount_template_order_placed_after").datepicker({ 
      minDate: 0,
      onSelect: function(date) {
                  $("#order_after").html(date)
      },
      dateFormat: 'd M yy'
    });
    
    $("#order_after").click(function(){
      $("#discount_template_order_placed_after").datepicker('show');
    });
    
  }
);