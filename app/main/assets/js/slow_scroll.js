
$(window).unbind("scroll").scroll(function () {
    document.body.style.backgroundPosition = "0px " + -(Math.max(document.documentElement.scrollTop, document.body.scrollTop) / 8) + "px";
});
