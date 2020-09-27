$ ->
  $("#customer_postcode").jpostal({
    postcode : [ "#customer_postcode" ],
    address  : {
                  "#customer_address" : "%3%4%5"
                }
  });