
app.directive('requestAnimation', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        $('.logo, .first').delay(600).fadeIn(500, function() {

            $element.click(function() {

                $('.page-head').animate({top: '-145px'}, 500, function() {
                    $('.black, .first').fadeOut(400);
                    $('.second').fadeIn(500, function() {
                        $(".request-buttons div").each(function(index) {
                            $(this).delay(300+index*100).animate({left: '250px'}, 200);
                        });
                    });
                });

                // $('.logo').delay(500).animate({top: '50px'}, 500)
                // $('.black, .first').fadeOut(400);
                //$(this).delay(500).animate({'top:100px'}, 400);
                //  $('.page-head').delay(500).animate({'top: 50px'}, 400, function () {
                //
                // });
            });
        });
    }
}});

app.directive('dropPin', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        // var image = new Image();
        // image.src = "/assets/images/atm-drop.gif";

        // $('.atm-drop').attr('src', atm-drop.gif);

        $('.atm-drop').delay(200).animate({top: '39%'}, 1500, 'easeOutBounce');

        $('.message').on('click', function() {
            $('#meetup-page .notification').fadeIn(400);
        });

        $('.okay-button, .notification').on('click', function() {
            $('#meetup-page .notification').fadeOut(400);
        });
    }
}});


app.directive('showNotification', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);
        $('.notification').delay(7000).fadeIn(300, 'easeInOutBack');
        $('.atm-search-single').delay(7000).fadeOut(300);
    }
}});


