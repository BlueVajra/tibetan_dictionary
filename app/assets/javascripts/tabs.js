window.Tabs = {
  initialize: function () {

    $tabs = $('#tabs ul li');
    $links = $tabs.find('a');
    $active = $($links[0]);

    $active.addClass('active');
    $container=$($active[0].hash);

    $links.not($active).each(function () {
      $(this.hash).hide();
    });

    $('#tabs ul').on("click", "a", this.tabLinkWasClicked.bind(this));

  },

  tabLinkWasClicked: function (e) {
    console.log($active)
    $active.removeClass('active');
    $container.hide();

    $active = $(e.target);
    $container = $($active[0].hash);

    $active.addClass('active');
    $container.show();

    e.preventDefault();
  }
};