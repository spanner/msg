#= require lib/jquery.peity

jQuery ($) ->
  $.activate_with () ->
    @find_including_self('span.pie').peity "pie",
      colours: ['#cacac8', '#74b87a', '#ed1c24']
