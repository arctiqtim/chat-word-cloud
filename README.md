Slack Word Cloud
===============

Word cloud of a Slack Export

This has been updated to a self-encapsulated Docker container.  No need to build a separate R development environment.  Simply follow the directions below to build and run a CentOS-based container that includes all required dependancies, and then runs an R script to build the wordcloud.

To generate the word cloud, follow the steps below.
![](export/wordcloud_transp.png)

Instructions
------------

1. Obtain a Slack "Team Export" dump of all the data for a team
2. Build the Docker image via the provided script `build.sh`
3. Customize the connect.sh script accordingly.  Ensure that you edit the volume paths accordingly. `docker run -it -v /home/tim/Downloads/SLACK:/slackexport:Z -v /home/tim/docker-rlang/export:/export:Z docker-slackwordcloud` The first volume declaration is for the Slack Export from Step 1.  The second is the export directory where the wordcloud will be written.  The container will build the wordcloud, providing both an original wordcloud and a version with a transparent background
4. Run the container/script via `connect.sh`
5. View your beautiful word cloud!

Inspirations
------------
[Gist explaining generating word clouds from slack](https://gist.github.com/michael-erasmus/eb0e30c4fba8ba5a5121)
