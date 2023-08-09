%% Roles %%
role(a).
role(b).

%% Input %%
input(R, act) :- role(R).

%% Initial state %%
init(out(a)).
init(out(b)).

% Legal moves %
legal(R, act) :- true(out(R)).

% Transition state %
next(in(R,T)) :- true(out(R)), does(R, act, T).
next(out(R)) :- true(out(R)), not(does(R, act, _)).
next(in(R,T)) :- true(in(R,T)).

% End game if someone is in 
terminal :- true(in(_, _)).

% Goal %
first(a,T) :- true(in(a,T)), true(out(b)).
first(b,T) :- true(in(b,T)), true(out(a)).
second(a,T) :- true(in(b,T)), true(out(a)).
second(b,T) :- true(in(a,T)), true(out(b)).
same(a,T) :- true(in(a,T)), true(in(b,T)).
same(b,T) :- true(in(a,T)), true(in(b,T)).

% First actor payoff function
firstpayoff(0.0,10).
firstpayoff(1.0,9).
firstpayoff(2.0,8).
firstpayoff(3.0,7).
firstpayoff(4.0,6).
firstpayoff(5.0,5).
firstpayoff(6.0,4).
firstpayoff(7.0,3).
firstpayoff(8.0,2).
firstpayoff(9.0,1).
firstpayoff(10.0,0).
% Second actor payoff function
secondpayoff(0.0,11).
secondpayoff(1.0,10).
secondpayoff(2.0,9).
secondpayoff(3.0,8).
secondpayoff(4.0,7).
secondpayoff(5.0,6).
secondpayoff(6.0,5).
secondpayoff(7.0,4).
secondpayoff(8.0,3).
secondpayoff(9.0,2).
secondpayoff(10.0,1).
% Simultaneuous payoff function
samepayoff(0.0,9).
samepayoff(1.0,8).
samepayoff(2.0,7).
samepayoff(3.0,6).
samepayoff(4.0,5).
samepayoff(5.0,4).
samepayoff(6.0,3).
samepayoff(7.0,2).
samepayoff(8.0,1).
samepayoff(9.0,0).
samepayoff(10.0,0).

goal(R,X) :- first(R,T), firstpayoff(T,X).
goal(R,X) :- same(R,T), samepayoff(T,X).
goal(R,X) :- second(R,T), secondpayoff(T,X).
