class App.RatingUpdater
  constructor: (@$el) ->
    @$rateWidget = @$el.find(".rateit")
    @_bindEvents()

  _bindEvents: ->
    @_onRated()

  _onRated: ->
    ratingUpdater = @
    @$rateWidget.on "rated", (_, rating) ->
      postId = $(@).data("post-id")

      ratingUpdater._updateRating(rating, postId)

  _updateRating: (rating, post_id) ->
    $.ajax
      method: "POST"
      url: "/posts/#{post_id}/ratings"
      data: { value: rating }

new App.RatingUpdater($(".post-rating"))
