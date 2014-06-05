window.GlossaryApp = {

  initialized: false,

  initialize: function () {
    if (!this.initialized) {
      this.initialized = true;
      $(document).on("ajax:success", "#definition_add", this.formWasSubmitted);
      $(document).on("click", ".edit", this.editLinkWasClicked);
    }
  },

  formWasSubmitted: function (event, json) {
    $("#definition_add").get(0).reset();

    var template = $("#definition-row").html();
    $.each(json, function (key, value) {
      template = template.replace(key.toUpperCase(), value);
    });

    $(".glossary_terms:first").append(template);
  },

  editLinkWasClicked: function (event) {
    // create a new template for edit in the html (new script tag, new id)
    // in that template, have a form - maybe with http://www.impressivewebs.com/html5-form-attribute/ (check compatibility)
    // hide the parent, and add a new edit row underneath
    //    so the cancel link just removes the edit row, and shows the original
    $(event.target).closest(".glossary_term").html("<td colspan=3>Yo dawg</td>");
    return false;  // don't follow the link
  }

};