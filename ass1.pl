% Zhichao He  z5282955 Assignment1-Prolog and Search

% sumsq_even(Numbers, Sum)
% Numbers: a list of integers 
% Sum: the sum of all the squares of the even numbers in the list

% Base case: empty list
% Return 0 as there is no number in the list
sumsq_even([], 0).
% otherwise
% If head of list is even, recurively call with the tail 
% and add the square of head to the Sum
sumsq_even([Head|Tail], Sum) :-
    0 is Head mod 2,
    sumsq_even(Tail, SumTail),
    Sum is SumTail + Head * Head.
% If head of list is odd, recursively call with the tail
% without changing the Sum
sumsq_even([Head|Tail], Sum) :-
    1 is Head mod 2,
    sumsq_even(Tail, Sum).



% log_table(NumberList,ResultList) 
% NumberList: a list of numbers
% ResultList: a list of pairs consisting of a number and its log, 
%             for each number in NumberList. 

% Base case: empty list
log_table([], []).
% otherwise
% Calculate the log of head and make a pair of head and its log
% [Head,Log], add the pair to the start of the ResultList
% then recursively call with the tail of NumberList
log_table([Head|Tail], [[Head,Log]|ResultTail]) :-
    Log is log(Head),
    log_table(Tail, ResultTail).



% paruns(List,RunList)
% List: a list of integers
% RunList: a list of list of integers where each list is a maximal
%         sequence of consecutive even or odd numbers within the
%         original list

% Base case: list with only one number
paruns([Num], [[Num]]).
% otherwise
% if head of List and head of head list in RunList is both odd
% insert the head to the start of the head list in RunList 
% (using headInsert)
paruns([Head|Tail], [[SubHead|SubTail]|RunTail]) :-
    paruns(Tail, [[SubHead1|SubTail1]|RunTail]),
    odd(Head), odd(SubHead1),
    headInsert(Head, [SubHead1|SubTail1], [SubHead|SubTail]).
% if head of List and head of head list in RunList is both even
% insert the head to the start of the head list in RunList 
% (using headInsert)
paruns([Head|Tail], [[SubHead|SubTail]|RunTail]) :-
    paruns(Tail, [[SubHead1|SubTail1]|RunTail]),
    even(Head), even(SubHead1),
    headInsert(Head, [SubHead1|SubTail1], [SubHead|SubTail]).
% if head of List and head of head list in RunList have different 
% parities make a new list containing only head of the List [Head]
% and insert [Head] to the start of RunList (using HeadInsert) 
paruns([Head|Tail], [RunHead|RunTail]) :-
    paruns(Tail, [RunHead1|RunTail1]),
    headInsert([Head], [RunHead1|RunTail1], [RunHead|RunTail]).

% helper predicates to determine the parity
odd(Num) :- integer(Num), 1 is Num mod 2.
even(Num) :- integer(Num), 0 is Num mod 2.

% helper predicates to insert a node to the start of a list
headInsert(NewHead, [], [NewHead]).
headInsert(NewHead, [Head|Tail], [NewHead, Head|Tail]).


% eval(Expr, Val)
% Expr: an arithmetic expression written in prefix format
% Val: the final value of the expression

% Base case: operation on two numbers
eval(add(X, Y), Result) :- 
    integer(X), integer(Y), 
    Result is X + Y.
eval(sub(X, Y), Result) :- 
    integer(X), integer(Y),
    Result is X - Y.
eval(mul(X, Y), Result) :- 
    integer(X), integer(Y),
    Result is X * Y.
eval(div(X, Y), Result) :- 
    integer(X), integer(Y),
    Result is X / Y.

% one of the expressions containing other expressions
% and the other expression is number

% addition
eval(add(Expr, X), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(add(ExprResult, X), Result).
eval(add(X, Expr), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(add(X, ExprResult), Result).

% subtraction
eval(sub(Expr, X), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(sub(ExprResult, X), Result).
eval(sub(X, Expr), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(sub(X, ExprResult), Result).

% multiplication 
eval(mul(Expr, X), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(mul(ExprResult, X), Result).
eval(mul(X, Expr), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(mul(X, ExprResult), Result).

% division
eval(div(Expr, X), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(div(ExprResult, X), Result).
eval(div(X, Expr), Result) :-
    integer(X),
    eval(Expr, ExprResult),
    eval(div(X, ExprResult), Result).

% both expressions contains other expressions 
eval(add(Expr1, Expr2), Result) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2),
    eval(add(Result1, Result2), Result).

eval(sub(Expr1, Expr2), Result) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2),
    eval(sub(Result1, Result2), Result).

eval(mul(Expr1, Expr2), Result) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2),
    eval(mul(Result1, Result2), Result).

eval(div(Expr1, Expr2), Result) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2),
    eval(div(Result1, Result2), Result).
