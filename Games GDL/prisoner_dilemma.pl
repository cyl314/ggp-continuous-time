%% Roles %%
role(a).
role(b).

%% Input %%
input(R, enter) :- role(R).

%% Initial state %%
init(state(a, coop)).
init(state(b, coop)).

% Legal moves %
legal(R, defect) :- true(state(R, coop)).
legal(R, coop) :- true(state(R, defect)).

% Transition state %
next(state(R, coop)) :- true(state(R, defect)), does(R, coop, T).
next(state(R, defect)) :- true(state(R, coop)), does(R, defect, T).

% Goal %
goal(R,X) :- true(state(R, defect)), true(state(S, defect)), R <> S, (X is 1).
goal(R,X) :- true(state(R, coop)), true(state(S, defect)), R <> S, (X is 0).
goal(R,X) :- true(state(R, defect)), true(state(S, coop)), R <> S, (X is 2).
goal(R,X) :- true(state(R, coop)), true(state(S, coop)), R <> S, (X is 3).