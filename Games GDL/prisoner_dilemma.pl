%% Roles %%
role(a).
role(b).

%% Input %%
input(R, enter) :- role(R).

%% Initial state %%
init(coop(a)).
init(coop(b)).
init(lastacttime(0)).

% Legal moves %
legal(R, defect) :- true(coop(R)).
legal(R, coop) :- true(defect(R)).

% Transition state %
next(coop(R)) :- true(defect(R)), does(R, coop, _).
next(coop(R)) :- true(coop(R)), not(does(R, defect, _)).
next(defect(R)) :- true(coop(R)), does(R, defect, _).
next(defect(R)) :- true(defect(R)), not(does(R, coop, _)).
next(lastacttime(T)) :- does(R,_,T), role(R).

terminal :- true(lastacttime(T)), T >= 10.

% Goal %
% Both cooperate
goalcoop(0.0,50).
goalcoop(1.0,45).
goalcoop(2.0,40).
goalcoop(3.0,35).
goalcoop(4.0,30).
goalcoop(5.0,25).
goalcoop(6.0,20).
goalcoop(7.0,15).
goalcoop(8.0,10).
goalcoop(9.0,5).
goalcoop(10.0,0).

% One betrays the other
goalbetray(0.0,100).
goalbetray(1.0,90).
goalbetray(2.0,80).
goalbetray(3.0,70).
goalbetray(4.0,60).
goalbetray(5.0,50).
goalbetray(6.0,40).
goalbetray(7.0,30).
goalbetray(8.0,20).
goalbetray(9.0,10).
goalbetray(10.0,0).

% Both defect
goaldefect(0.0,20).
goaldefect(1.0,18).
goaldefect(2.0,16).
goaldefect(3.0,14).
goaldefect(4.0,12).
goaldefect(5.0,10).
goaldefect(6.0,8).
goaldefect(7.0,6).
goaldefect(8.0,4).
goaldefect(9.0,2).
goaldefect(10.0,0).

goal(a,X) :- true(defect(a)), true(defect(b)), true(lastacttime(T)), goalcoop(T,X).
goal(b,X) :- true(defect(a)), true(defect(b)), true(lastacttime(T)), goalcoop(T,X).

goal(a,0) :- true(coop(a)), true(defect(b)).
goal(b,0) :- true(coop(b)), true(defect(a)).

goal(a,X) :- true(defect(a)), true(coop(b)), true(lastacttime(T)), goalbetray(T,X).
goal(b,X) :- true(defect(b)), true(coop(a)), true(lastacttime(T)), goalbetray(T,X).

goal(a,X) :- true(coop(a)), true(coop(b)), true(lastacttime(T)), goaldefect(T,X).
goal(b,X) :- true(coop(a)), true(coop(b)), true(lastacttime(T)), goaldefect(T,X).
