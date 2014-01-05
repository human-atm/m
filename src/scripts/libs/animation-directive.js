
app.directive('requestAnimation', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        console.log('yo')

        $element.css({background:'red'});
        // put code here

    }
}});




app.directive('lolAnimation', function() { return {

    restrict: "C",
    link: function (scope, element) {
        $element = $(element);

        console.log('yo')

        $element.css({background:'red'});
        // put code here

    }
}});

