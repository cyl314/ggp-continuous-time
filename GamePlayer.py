import sys
from pyswip import Prolog
import socket
import random
import time

class GamePlayer():
    def __init__(self, gdl, role):
        # Read rules
        self.prolog = Prolog()
        self.prolog.consult(gdl)
        self.role = role

    def choose_move_time(self, start, fin):
        return random.randint(start, fin)
    
    def choose_move(self, movelist):
        moves = []
        for i in movelist:
            moves.append(i['X'])
        if len(moves) > 0:
            return random.choice(moves)
        else:
            return "NOMOVE"

    def response(self):
        return random.random() > 0.5

