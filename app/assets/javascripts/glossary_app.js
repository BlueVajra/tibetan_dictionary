window.GlossaryApp = {

  initialized: false,

  initialize: function () {
    if (!this.initialized) {
      this.initialized = true;
      $(document).on("ajax:success", "#definition_add", this.formWasSubmitted.bind(this));
      $(document).on("click", ".edit", this.editLinkWasClicked.bind(this));
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
    var $showRow = $(".glossary_term[data-definition-id=" + json.definition_id + "]");

    var renderedTemplate = this.renderTemplate("#definition-row", json);


    $(event.target).closest(".edit_row").remove();
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

    var renderedTemplate = this.renderTemplate("#definition-row-edit", json);
    $row.before(renderedTemplate).hide();

    return false;
  },

  renderTemplate: function (templateName, object) {
    var template = $(templateName).html();
    $.each(object, function (key, value) {
      upKey = new RegExp(key.toUpperCase(), 'g');
      template = template.replace(upKey, value);
    });
    return template;
  }
};