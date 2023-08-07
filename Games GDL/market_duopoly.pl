%% Roles %%
role(a).
role(b).

%% Input %%
input(R, enter) :- role(R).

%% Initial state %%
init(state(a, out)).
init(state(b, out)).

% Legal moves %
legal(R, enter) :- true(state(R, out)).

% Transition state %
next(state(R, in(T))) :- true(state(R, out)), does(R, enter, T).
next(state(R, out)) :- true(state(R, out)), not(does(R, enter, _)).
next(state(R, in(T))) :- true(state(R, in(T))).

% End game if both players enter the market
terminal :- true(state(a, in(_))), true(state(b, in(_))).

% Goal %
first(a,TA) :- true(state(a, in(TA))), true(state(b,  in(TB))), (TA > TB).
first(b,TB) :- true(state(a, in(TA))), true(state(b,  in(TB))), (TA < TB).
second(a,TA) :- true(state(a, in(TA))), true(state(b,  in(TB))), (TA < TB).
second(b,TB) :- true(state(a, in(TA))), true(state(b,  in(TB))), (TA > TB).
same(a,T) :- true(state(a, in(T))), true(state(b,  in(T))).
same(a,T) :- true(state(a, in(T))), true(state(b,  in(T))).

goal(R,X) :- first(R,T), (X is 10-T).
goal(R,X) :- same(R,T), (X is 9-T).
goal(R,X) :- second(R,T), (X is 11-T).