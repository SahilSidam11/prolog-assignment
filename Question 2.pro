% River crossing state representation
% state(Left, BoatPosition, Right)
% Each side will contain lists of people left there.
initial_state(state([man, woman, child1, child2], left, [])).

% Final state when everyone is on the right bank
final_state(state([], right, [man, woman, child1, child2])).

% Define safe boat transitions
boat_move(state(L1, left, R1), state(L2, right, R2)) :-
    select(Person, L1, L1_),
    safe_crossing([Person]),
    L2 = L1_,
    R2 = [Person|R1].

boat_move(state(L1, left, R1), state(L2, right, R2)) :-
    select(Person1, L1, L1_),
    select(Person2, L1_, L2),
    safe_crossing([Person1, Person2]),
    R2 = [Person1, Person2|R1].

boat_move(state(L1, right, R1), state(L2, left, R2)) :-
    select(Person, R1, R1_),
    L2 = [Person|L1],
    R2 = R1_.

boat_move(state(L1, right, R1), state(L2, left, R2)) :-
    select(Person1, R1, R1_),
    select(Person2, R1_, R2),
    L2 = [Person1, Person2|L1].

% Check if crossing is safe
safe_crossing(People) :-
    total_weight(People, Weight),
    Weight =< 100.

% Calculate total weight
total_weight(People, Weight) :-
    maplist(weight, People, Weights),
    sumlist(Weights, Weight).

% Define weights
weight(man, 80).
weight(woman, 80).
weight(child1, 30).
weight(child2, 30).

% Solve the puzzle by finding a sequence of moves
solve_river_crossing(Plan) :-
    initial_state(InitialState),
    plan_moves(InitialState, [], Plan).

% Plan sequence of moves to reach final state
plan_moves(State, Visited, []) :-
    final_state(State).

plan_moves(State, Visited, [Move|Moves]) :-
    boat_move(State, NewState),
    \+ member(NewState, Visited),
    plan_moves(NewState, [NewState|Visited], Moves).
