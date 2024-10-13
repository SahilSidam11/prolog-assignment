
% Family relation rules
father(X, Y) :- parent(X, Y), male(X).
parent(john, jim). % John is Jim's father
parent(jim, bob).  % Jim is Bob's father
male(john).
male(jim).
male(bob).

% Solve the riddle
solve_riddle(Who) :-
    parent(X, Who), % X is that man's father
    father(X, Y),   % X is my father
    father(Y, Who). % Y is my father's son (so X is also my father)
