
app.directive('requestAnimation', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        $('.logo, .first').delay(600).fadeIn(500, function() {
            $('.page-head').delay(800).animate({top: '-145px'}, 500, function() {
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

    }
}});


app.directive('showNotification', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        $('.notification').delay(2000).fadeIn(300, 'easeInOutBack');

    }
}});


