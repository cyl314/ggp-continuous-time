# ggp-continuous-time

Offline implementation of game manager and player for continuous time games based off Greg Kulhmann's work (https://github.com/antonini3/python-ggp).

GDL for sample games in "Games GDL" folder are written in Prolog. Pyswip (https://github.com/yuce/pyswip) needs to be installed first to process Prolog queries in Python. 

To run, execute the following:
python .\GameManager.py <GDL location> <Game duration in seconds>

For example, to run War of Attrition, execute:
python .\GameManager.py "./Games GDL/war_attrition.pl" 10



