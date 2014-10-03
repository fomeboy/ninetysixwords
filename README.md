ninetysixwords
==============

A web experiment that picks up random tweets containing the words love or hate and displays it on the browser canvas element. 
Server runs on nodeJS with express serving a static page, connects to twitter via node-twitter API, and feeds a processingJS sketch using socket.io. 

(Sound not working on IOS mobile devices since autoplay is disabled).

The app is currently set to run on local host, port 3000

The HTML file contains two references for audio sources which you should replace with your own sounds and add the corresponding files to the public folder

The file env.jason should be filled your your own twitter api access tokens
