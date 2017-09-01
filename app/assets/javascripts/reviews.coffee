$( document ).on 'turbolinks:load', ->

  # Read and convert numeric rating to Stars (on views/reviews/_review):
  $( '.review-rating' ).raty
    path: '/assets'
    readOnly: true
    score: ->
      $( this ).attr( 'data-score' )
  #reload to remove ghost stars on browser back tracing:
  $( '.review-rating' ).raty( 'reload' )

  # Read and convert numeric rating to Stars, set Star rating (on views/reviews/_form):
  $( '#rating-form' ).raty
    path: '/assets'
    scoreName: 'review[rating]'
    score: ->
      $( this ).attr( 'data-score' )
  $( '#rating-form' ).raty( 'reload' )

  $(' #review-form-container ' ).on 'show-stars',  ->
    $( '#rating-form' ).raty
      path: '/assets'
      scoreName: 'review[rating]'
      score: ->
        $( this ).attr( 'data-score' )
    $( '#rating-form' ).raty( 'reload' )

  $('.average-review-rating').raty
    readOnly: true
    path: '/assets/'
    score: ->
      $(this).attr 'data-score'
  $('.average-review-rating').raty( 'reload' )
