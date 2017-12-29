Chat Word Cloud
===============

Word cloud of the Code &amp; Supply chat

To generate the word cloud, follow the steps below.
![](export/wordcloud_transp.png)

Instructions
------------

1. Obtain a Slack "Team Export" dump of all the data for a team
2. Build the Docker image via the provided script `build.sh`
3. Customize the connect.sh script accordingly.  Ensure that you edit the volume paths accordingly. `docker run -it -v /home/tim/Downloads/SLACK:/slackexport:Z -v /home/tim/docker-rlang/export:/export:Z docker-slackwordcloud` The first volume declaration is for the Slack Export from Step 1.  The second is 
6. View your beautiful word cloud!

Inspirations
------------
[Gist explaining generating word clouds from slack](https://gist.github.com/michael-erasmus/eb0e30c4fba8ba5a5121)
