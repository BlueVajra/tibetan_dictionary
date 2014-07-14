window.CommentsApp = {

  initialize: function (term) {
    var jqxhr = $.get("/tib_terms/" + term + "/comments", function (data) {
//      console.log(data)
      CommentsApp.getCommentsSuccess(data)
    })

    $(document).on("ajax:success", "#add_comment form", this.addCommentWasSubmitted.bind(this));
  },

  getCommentsSuccess: function (json) {
    console.log(json)
    $.each(json, function(commentsID,comment) {
      renderedTemplate = JST['templates/comment']({comment: comment});

      $("#comments").prepend(renderedTemplate);
    });

  },

  addCommentWasSubmitted: function (event, json) {
    $("#add_comment form").get(0).reset();

    renderedTemplate = JST['templates/comment']({comment: json});

    $("#comments").prepend(renderedTemplate);
  }

};