#!/bin/bash

Rscript slack-wordcloud.r
convert /export/wordcloud.png -transparent white /export/wordcloud_transp.png