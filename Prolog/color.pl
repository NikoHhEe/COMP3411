variables([wa=_, nt=_, q=_, nsw=_, v=_, sa=_, t=_]).
domain(red).
domain(green).
domain(blue).
connected(wa, nt).
connected(wa, sa).
connected(nt, q).
connected(nt, sa).
connected(sa, q).
connected(sa, nsw).
connected(sa, v).
connected(q, nsw).
connected(v, nsw).
adjacent(A, B) :- connected(A, B).
adjacent(A, B) :- connected(B, A).

solve(V) :-
    variables(V),
    assign_all(V).
assign_all([]).
assign_all([State|OtherVariables]):-
    assign_all(OtherVariables),
    assign_variable(State, OtherVariables).
assign_variable(Var = Colour, OtherVariables) :-
    domain(Colour),
    constraint(Var = Colour, OtherVariables).
constraint(S1 = C, OtherVariables) :-
    findall(S, (adjacent(S1, S), member(S = C, OtherVariables)), []).