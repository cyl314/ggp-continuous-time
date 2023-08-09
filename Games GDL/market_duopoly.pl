%% Roles %%
role(a).
role(b).

%% Input %%
input(R, enter) :- role(R).

%% Initial state %%
init(out(a)).
init(out(b)).

% Legal moves %
legal(R, enter) :- true(out(R)).

% Transition state %
next(in(R,T)) :- true(out(R)), does(R, enter, T).
next(out(R)) :- true(out(R)), not(does(R, enter, _)).
next(in(R,T)) :- true(in(R,T)).

% End game if both players enter the market
terminal :- true(in(a,_)), true(in(b, _)).

% Goal %
first(a,TA) :- true(in(a, TA)), true(in(b,TB)), (TA < TB).
first(a,TA) :- true(in(a, TA)), true(out(b)).
first(b,TB) :- true(in(a, TA)), true(in(b,TB)), (TA > TB).
first(b,TB) :- true(out(a)), true(in(b,TB)).

second(a,TA) :- true(in(a, TA)), true(in(b,TB)), (TA > TB).
second(a,10.0) :- true(out(a)), true(in(b,_)).
second(b,TB) :- true(in(a, TA)), true(in(b,TB)), (TA < TB).
second(b,10.0) :- true(in(a, _)), true(out(b)).

same(a,T) :- true(in(a, T)), true(in(b,T)).
same(b,T) :- true(in(a, T)), true(in(b,T)).

% First actor payoff function
firstpayoff(0.0,1.0,16).	
firstpayoff(0.0,2.0,17).	
firstpayoff(0.0,3.0,17).	
firstpayoff(0.0,4.0,16).	
firstpayoff(0.0,5.0,16).	
firstpayoff(0.0,6.0,15).	
firstpayoff(0.0,7.0,13).	
firstpayoff(0.0,8.0,11).	
firstpayoff(0.0,9.0,9).	
firstpayoff(0.0,10.0,6).
firstpayoff(1.0,2.0,15).
firstpayoff(1.0,3.0,15).	
firstpayoff(1.0,4.0,15).	
firstpayoff(1.0,5.0,14).	
firstpayoff(1.0,6.0,14).	
firstpayoff(1.0,7.0,12).	
firstpayoff(1.0,8.0,11).	
firstpayoff(1.0,9.0,8).	
firstpayoff(1.0,10.0,6).
firstpayoff(2.0,3.0,13).	
firstpayoff(2.0,4.0,13).	
firstpayoff(2.0,5.0,13).	
firstpayoff(2.0,6.0,12).	
firstpayoff(2.0,7.0,11).	
firstpayoff(2.0,8.0,10).	
firstpayoff(2.0,9.0,8).	
firstpayoff(2.0,10.0,5).
firstpayoff(3.0,4.0,12).	
firstpayoff(3.0,5.0,12).	
firstpayoff(3.0,6.0,11).	
firstpayoff(3.0,7.0,10).	
firstpayoff(3.0,8.0,9).	
firstpayoff(3.0,9.0,7).	
firstpayoff(3.0,10.0,5).
firstpayoff(4.0,5.0,10).	
firstpayoff(4.0,6.0,10).	
firstpayoff(4.0,7.0,9).	
firstpayoff(4.0,8.0,8).	
firstpayoff(4.0,9.0,7).	
firstpayoff(4.0,10.0,5).
firstpayoff(5.0,6.0,9).	
firstpayoff(5.0,7.0,8).	
firstpayoff(5.0,8.0,7).	
firstpayoff(5.0,9.0,6).	
firstpayoff(5.0,10.0,4).
firstpayoff(6.0,7.0,7).	
firstpayoff(6.0,8.0,6).	
firstpayoff(6.0,9.0,5).	
firstpayoff(6.0,10.0,4).
firstpayoff(7.0,8.0,5).	
firstpayoff(7.0,9.0,4).	
firstpayoff(7.0,10.0,3).
firstpayoff(8.0,9.0,4).	
firstpayoff(8.0,10.0,3).
firstpayoff(9.0,10.0,2).

% Second actor payoff function
secondpayoff(0.0,1.0,14).
secondpayoff(0.0,2.0,12).
secondpayoff(0.0,3.0,10).
secondpayoff(0.0,4.0,9).
secondpayoff(0.0,5.0,7).
secondpayoff(0.0,6.0,6).
secondpayoff(0.0,7.0,4).
secondpayoff(0.0,8.0,3).
secondpayoff(0.0,9.0,2).
secondpayoff(0.0,10.0,1).
secondpayoff(1.0,2.0,12).
secondpayoff(1.0,3.0,11).
secondpayoff(1.0,4.0,9).
secondpayoff(1.0,5.0,7).
secondpayoff(1.0,6.0,6).
secondpayoff(1.0,7.0,5).
secondpayoff(1.0,8.0,3).
secondpayoff(1.0,9.0,2).
secondpayoff(1.0,10.0,1).
secondpayoff(2.0,3.0,11).
secondpayoff(2.0,4.0,9).
secondpayoff(2.0,5.0,8).
secondpayoff(2.0,6.0,6).
secondpayoff(2.0,7.0,5).
secondpayoff(2.0,8.0,4).
secondpayoff(2.0,9.0,2).
secondpayoff(2.0,10.0,1).
secondpayoff(3.0,4.0,10).
secondpayoff(3.0,5.0,8).
secondpayoff(3.0,6.0,7).
secondpayoff(3.0,7.0,5).
secondpayoff(3.0,8.0,4).
secondpayoff(3.0,9.0,2).
secondpayoff(3.0,10.0,1).
secondpayoff(4.0,5.0,8).
secondpayoff(4.0,6.0,7).
secondpayoff(4.0,7.0,5).
secondpayoff(4.0,8.0,4).
secondpayoff(4.0,9.0,2).
secondpayoff(4.0,10.0,1).
secondpayoff(5.0,6.0,7).
secondpayoff(5.0,7.0,5).
secondpayoff(5.0,8.0,4).
secondpayoff(5.0,9.0,3).
secondpayoff(5.0,10.0,1).
secondpayoff(6.0,7.0,6).
secondpayoff(6.0,8.0,4).
secondpayoff(6.0,9.0,3).
secondpayoff(6.0,10.0,1).
secondpayoff(7.0,8.0,4).
secondpayoff(7.0,9.0,3).
secondpayoff(7.0,10.0,1).
secondpayoff(8.0,9.0,3).
secondpayoff(8.0,10.0,1).
secondpayoff(9.0,10.0,1).

% Simultaneuous payoff function
samepayoff(0.0,15).
samepayoff(1.0,14).
samepayoff(2.0,13).
samepayoff(3.0,11).
samepayoff(4.0,10).
samepayoff(5.0,9).
samepayoff(6.0,7).
samepayoff(7.0,6).
samepayoff(8.0,4).
samepayoff(9.0,3).
samepayoff(10.0,1).


goal(R,X) :- first(R,T), second(_, S), firstpayoff(T,S,X).
goal(R,X) :- same(R,T), samepayoff(T,X).
goal(R,X) :- first(_,T), second(R,S), secondpayoff(T,S,X).