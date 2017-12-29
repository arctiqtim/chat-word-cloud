# our R base image
FROM docker.io/centos

RUN yum install -y epel-release

RUN yum update -y && yum install -y libxml2 libxml2-devel R ImageMagick
# install packages
# these are ones I like
RUN echo 'install.packages(c("jsonlite", "tm", "wordcloud", "ggplot2", "plyr", "reshape2", "RColorBrewer", "scales","grid", "wesanderson"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
    && Rscript /tmp/packages.R

# create an R user
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

WORKDIR $HOME
USER user

# Copy in the scripts to run
COPY slack-wordcloud.r $HOME/slack-wordcloud.r
COPY entrypoint.sh $HOME/entrypoint.sh

# set the command
ENTRYPOINT sh $HOME/entrypoint.sh
