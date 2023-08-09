from pyswip import Prolog
import time
from util import Timer
import socket 
from _thread import *
import sys
import random
from GamePlayer import GamePlayer

# Game Manager
class GameManager:
    def __init__(self, gdl):
        # Read rules
        self.prolog = Prolog()
        self.prolog.consult(gdl)

        # Get roles
        print("Roles are: ")
        roles_q = list(self.prolog.query("role(X)"))
        self.roles = []
        for role in roles_q:
            self.roles.append(role['X'])
            print(role['X'])

    def start_game(self):
        
        # Set initial states
        self.set_initial_state()     

        # Start timer
        self.start_clock()

    def set_initial_state(self):
        print('Set initial state')
        init_q = list(self.prolog.query('init(X)'))
        
        self.current_state = []
        for init in init_q:
            print(init['X'])
            state = 'true(' + init['X'] + ')'
            self.current_state.append(state)
            self.prolog.assertz(state)
    
    def start_clock(self):
        self.timer = Timer()

    def check_legal(self, role, move):
        check = list(self.prolog.query("legal("+role+","+ move+ ")"))
        return len(check) > 0

    def action_update(self, rolelist, movelist):
        time = str(round(self.timer.split(),0))

        self.action_list = []
        for role, move in zip(rolelist, movelist):
            #print(role, move)
            if self.check_legal(role, move):
                print("Move is legal")

                # Execute move
                action = 'does(' + role + ',' + move + ',' + time + ')'
                self.action_list.append(action)
                self.prolog.assertz(action)

                # Update state based on move
                self.state_update()
            else:
                print("Move is illegal")
        
        # Retract action facts
        for action in self.action_list:
            self.prolog.retract(action)

    def state_update(self):
        next_q = list(self.prolog.query('next(X)'))
        #print(next_q)

        # Retract old state
        for state in self.current_state:
            self.prolog.retract(state)

        # Update new state
        self.current_state = []
        for next in next_q:
            #print(next['X'])
            state = 'true(' + next['X'] + ')'
            if state not in self.current_state:
                self.current_state.append(state)
                self.prolog.assertz(state)

    def check_termination(self):
        terminate_chk = list(self.prolog.query('terminal'))
        return len(terminate_chk) > 0

    def calculate_goal(self):
        goal_q = list(self.prolog.query('goal(R, X)'))
        return goal_q


def main():
    
    # Read rules
    gdl = sys.argv[1] 
    game_duration = int(sys.argv[2]) # Game duration in seconds
    
    print('Starting GM server')
    gm = GameManager(gdl)

    # Starting server
    print('Waiting for players')
    
    # Create game players and assign roles
    gp1 = GamePlayer(gdl, gm.roles[0])
    gp2 = GamePlayer(gdl, gm.roles[1])
    
    print("Start game")
    gm.start_game()
    
    # Wait for player send move
    current_time = gm.timer.split()
    
    while (gm.check_termination() == False) and (current_time < game_duration):
        print('Awaiting player move')

        # Players choose random legal move and time 
        player1_time = gp1.choose_move_time(0, game_duration)
        player2_time = gp2.choose_move_time(0, game_duration)

        player1_move = gp1.choose_move(list(gm.prolog.query('legal('+gp1.role+',X)')))
        player2_move = gp2.choose_move(list(gm.prolog.query('legal('+gp2.role+',X)')))

        # Determine next move time
        next_move_list = []
        next_move_role = []
        if player1_move == "NOMOVE" and player2_move == "NOMOVE":
            break
        elif player1_move == "NOMOVE":
            if round(current_time + player2_time) > game_duration:
                break
            else:
                next_move_time = player2_time
                next_move_list.append(player2_move)
                next_move_role.append(gp2.role)
        elif player2_move == "NOMOVE":
            if round(current_time + player1_time) > game_duration:
                break
            else:
                next_move_time = player1_time
                next_move_list.append(player1_move)
                next_move_role.append(gp1.role)
        elif player1_time < player2_time:
            if round(current_time + player1_time) > game_duration:
                break
            else:
                next_move_time = player1_time
                next_move_list.append(player1_move)
                next_move_role.append(gp1.role)
        elif player1_time > player2_time:
            if round(current_time + player2_time) > game_duration:
                break
            else:
                next_move_time = player2_time
                next_move_list.append(player2_move)
                next_move_role.append(gp2.role)
        else:
            if round(current_time + player1_time) > game_duration:
                break
            else:
                next_move_time = player1_time
                next_move_list.append(player1_move)
                next_move_list.append(player2_move)
                next_move_role.append(gp1.role)
                next_move_role.append(gp2.role)
        
        time.sleep(next_move_time)
        acttime = str(round(gm.timer.split(),0))
        for role, move in zip(next_move_role, next_move_list):
            print("Player "+ role + " submits " + move + " at t = " + acttime)

        print('Perform state update')

        gm.action_update(next_move_role, next_move_list)

        # Freeze game clock
        if len(next_move_role) < len(gm.roles):
            gm.timer.freeze()
            print("Freeze game clock")

            response_move = []
            response_role = []
            for player in [gp1, gp2]:
                if player.role not in next_move_role:
                    response_role.append(player.role)
                    # Player chooses to respond
                    if player.response():
                        response_role.append(player.role)
                        response_move.append(player.choose_move(list(gm.prolog.query('legal('+player.role+',X)'))))
                    else:                 
                        response_move.append("NOMOVE")
                        
            time.sleep(5)
            
            next_move_list = []
            next_move_role = []
            for role, move in zip(response_role, response_move):
                if move != "NOMOVE":
                    print("Player "+ role + " responds immediately with " + move)
                    next_move_role.append(role)
                    next_move_list.append(move)
                else:       
                    print("Player "+ role + " did not respond")
            gm.timer.unfreeze()
            gm.action_update(next_move_role, next_move_list)

        print("Updated states")
        print(list(gm.prolog.query("true(X)")))

        current_time = gm.timer.split()

    # Print end game
    print("Terminal state reached - Ending game")

    # Calculate goal for both players
    print("Calculating game score")
    scores = gm.calculate_goal()
    print(scores)
    # Calculate winner 
    winner_list = []
    winner_score = 0
    for score in scores:
        if len(winner_list) == 0:
            winner_score = score['X']
            winner_list = [score['R']]
        elif score['X'] > winner_score:
            winner_score = score['X']
            winner_list = [score['R']]
        elif score['X'] == winner_score:
            winner_list.append(score['R'])

    if len(winner_list) == 1:
        print('Winner is', winner_list[0])
    else:
        print('Winners are:')
        for i in winner_list:
            print(i)
            
if __name__ == '__main__':
    main()