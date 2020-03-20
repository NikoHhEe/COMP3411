:- use_module(library(clpfd)).

solve(A, B, C, D, E) :-
    constraints(A, B, C, D, E),
    labeling([], [A, B, C, D, E]).

constraints(A, B, C, D, E) :-
    [A, B, C, D, E] ins 1..4,
    A #> D,
    D #> E,
    C #\= A,
    C #> E,
    C #\= D,
    B #>= A,
    B #\= C,
    C #\= D + 1.

% Cryptarithmetic puzzle DONALD + GERALD = ROBERT in CLP(FD)
solve([D,O,N,A,L,D],[G,E,R,A,L,D],[R,O,B,E,R,T]) :-
    Vars = [D,O,N,A,L,G,E,R,B,T],   % All variables in the puzzle
    Vars ins 0..9,                  % They are all decimal digits
    all_different(Vars),            % They are all different
    100000*D + 10000*O + 1000*N + 100*A + 10*L + D +
    100000*G + 10000*E + 1000*R + 100*A + 10*L + D #=
    100000*R + 10000*O + 1000*B + 100*E + 10*R + T,
    labeling([], Vars).

% The k-th element of Cols is the column number of the queen in row k.
n_queens(N, Qs) :-
    length(Qs, N),
    Qs ins 1..N,
    safe_queens(Qs).

safe_queens([]).
safe_queens([Q|Qs]) :-
    safe_queens(Qs, Q, 1),
    safe_queens(Qs).

safe_queens([], _, _).
safe_queens([Q|Qs], Q0, D0) :-
    Q0 #\= Q,
    abs(Q0 - Q) #\= D0,
    D1 #= D0 + 1,
    safe_queens(Qs, Q0, D1).

:- use_module(library(clpr)).
mg(P, T, I, B, MP):-
    { T = 1,
      B + MP = P * (1 + I)
    }.
mg(P, T, I, B, MP):-
    { T > 1,
      P1 = P * (1 + I) - MP,
      T1 = T - 1
    },
    mg(P1, T1, I, B, MP).

% case 1: Substitute whole term
substitute(Term, Term, Term1, Term1) :- !.

% case 2: Nothing to substitute if Term atomic
substitute(_, Term, _, Term) :- 
    atomic(Term), !.                    % Term is a constant

% case 3: Do substitution on arguments
substitute(Sub, Term, Sub1, Term1) :-
    Term =.. [F|Args],                  % get arguments
    subslist(Sub, Args, Sub1, Args1),   % perform substitution on term
    Term1 =.. [F|Args1].                % construct Term1

% End of list, nothing to do
subslist(_, [], _, []).

% If found sub term, replace it in new list
subslist(A, [A|List], B, [B|List1]) :-
    subslist(A, List, B, List1).

% Otherwise, try substituting recursively
subslist(A, [X|List], B, [Y|List1]) :-
    substitute(A, X, B, Y),
    subslist(A, List, B, List1).