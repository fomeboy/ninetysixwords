/*jslint node:true, es5:true, nomen: true*/


"use strict";

//INSTANCE INITIALIZATION
var express = require("express"),
    app = express(),
    http = require("http").Server(app),
    twitter = require("node-twitter"),
    env = require("./env.json"),
    io = require("socket.io")(http),
    path = require('path');

app.use(express.static(__dirname + '/public'));

//SOCKET CONNECTION
io.on('connection', function (socket) {
    console.log('a user connected');
});



//TWITTR API CALL - SEARCH
var twitterSearchClient = new twitter.SearchClient(
    env.twitter_consumer_key,
    env.twitter_consumer_secret,
    env.twitter_access_token_key,
    env.twitter_access_token_secret
);

var tweet_text, tweet_type, prev_tweet;

setInterval(function () {

    twitterSearchClient.search({'q': 'hate OR love', 'result_type' : 'recent', 'count' : 1}, function (error, result) {
        if (error) {
            console.log('Error: ' + (error.code ? error.code + ' ' + error.message : error.message));
        }

        if (result && result.statuses[0]) {

            tweet_text = result.statuses[0].text;


            if (tweet_text.search(/love/i) === -1) {
                tweet_type = 'hate';
            } else {
                tweet_type = 'love';
            }


            if (tweet_text.search(/\n/i) === -1 && tweet_text !== prev_tweet) {

                prev_tweet = tweet_text;
                //io.emit('tweet', JSON.stringify({tweet_type: tweet_type, tweet_text: tweet_text}));
                io.emit('tweet', {tweet_type: tweet_type, tweet_text: tweet_text});
                console.log(tweet_text);
            }
        }
    });
}, 20000);



//SET PORT LISTENING
http.listen(3000, function () {
    console.log('listening on port 3000');
});
