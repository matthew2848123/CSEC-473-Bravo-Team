#!/bin/bash
curl https://raw.githubusercontent.com/sKannanaikal/CDT-Scoring-Engine/main/app.py -o scoring-server.py
curl https://raw.githubusercontent.com/sKannanaikal/CDT-Scoring-Engine/main/index.html -o index.html

mkdir /root/scoring-engine

mv /root/scoring-server.py /root/scoring-engine/scoring-server.py 
mv /root/index.html /root/scoring-engine/index.html

mkdir /root/scoring-engine/templates
mv /root/scoring-engine/index.html /root/scoring-engine/templates/index.html