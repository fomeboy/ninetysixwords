/*jshint strict: true*/
/*global Processing, io*/
var ninetysixwords = ninetysixwords || {};

ninetysixwords = (function () {
    "use strict";
    
    var feedSketch, socket_listen, music_init;
       

    feedSketch = function () {
        
        window.addEventListener('resize', function (event) {

            var canvElem = document.getElementById("canvas1"),
                newWidth = document.documentElement.clientWidth,
                newHeight = document.documentElement.clientHeight;

            canvElem.setAttribute("width", newWidth);
            canvElem.setAttribute("height", newHeight);
            
            Processing.getInstanceById('canvas1').setSize(newWidth, newHeight);
            
        });
        
    };
    
    socket_listen = function () {
 
        var parsed_jason,
            socket = io.connect('http://localhost:3000/');

        socket.on('tweet', function (data) {
            Processing.getInstanceById('canvas1').injectFlake(data.tweet_text, data.tweet_type);
        });
    
    };
    

    return { feedSketch: feedSketch,
             socket_listen: socket_listen};
    
}());