window.GlossaryApp = {

  initialized: false,

  initialize: function () {
    if (!this.initialized) {
      this.initialized = true;
      $(document).on("ajax:success", "#definition_add", this.formWasSubmitted.bind(this));
      $(document).on("click", ".edit", this.editLinkWasClicked.bind(this));
      $(document).on("click", ".cancel", this.cancelLinkWasClicked.bind(this));
      $(document).on("ajax:success", ".definition_edit", this.editFormWasSubmitted.bind(this));
    }
  },

  formWasSubmitted: function (event, json) {
    $("#definition_add").get(0).reset();

    renderedTemplate = JST['templates/term']({term: json});

//    var renderedTemplate = this.renderTemplate("#definition-row", json);
    $(".glossary_terms:last").append(renderedTemplate);
  },

  editFormWasSubmitted: function (event, json) {
    console.log('got here')
    var $showRow = $(".glossary_term[data-definition-id=" + json.definition_id + "]");

    renderedTemplate = JST['templates/term']({term: json});
    $showRow.before(renderedTemplate);
    $(event.target).closest(".edit_row").remove();
    $showRow.remove();
  },

  cancelLinkWasClicked: function (event){
    var $editRow = $(event.target).closest(".glossary_edit")
    var id = $editRow.find('form').attr('id')
    var $oldRow = $(".glossary_term[data-definition-id=" + id + "]");
    $editRow.remove();
    $oldRow.show();

    event.preventDefault();
    return false;
  },

  editLinkWasClicked: function (event) {

    var $row = $(event.target).closest(".glossary_term");
    var $href = $(event.target).attr('href')
    var $definition_id = $href.match(/\d*?$/)
    var json = {
      wyl: $row.find(".wyl").text(),
      entry: $row.find(".entry").text(),
      definition_path: $href,
      definition_id: $definition_id,
    };

    renderedTemplate = JST['templates/term_edit']({term: json});
    $row.before(renderedTemplate).hide();

    return false;
  }


};