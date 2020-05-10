% A grammar the covers most of the examples in COMP3411 lectures

:- dynamic(history/1).

sentence(VP) --> noun_phrase(Number, Actor), verb_phrase(Actor, Number, VP).

noun_phrase(plural, set(NP1, NP2)) --> np1(_, NP1), [and], noun_phrase(_, NP2).
noun_phrase(Number, NP1) --> np1(Number, NP1).

np1(Number, thing(Noun, Properties)) -->
	determiner(Number, _),
	adjp(Properties),
	noun(Number, Noun).
np1(Number, thing(Noun, [PP | Properties])) -->
	determiner(Number, _),
	adjp(Properties),
	noun(Number, Noun),
	pp(Number, PP).
np1(Number, thing(Name, [])) -->
	proper_noun(Number, _, Name).
np1(Number, personal(Pro)) -->
	pronoun(Number, _, Pro).
np1(Number1, possessive(Pos, NP)) -->
	possessive_pronoun(Number1, _, Pos), noun_phrase(_, NP).
np1(Number, object(Noun)) -->
	num(Number), noun(Number, Noun).

adjp([Adj]) --> adjective(Adj).
adjp([]) --> [].

verb_phrase(Actor, Number, event(V, [actor(Actor) | Adv])) -->
	verb(Number, V),
	adverb(Adv).
verb_phrase(Actor, Number, event(V, [actor(Actor), object(NP) | Adv])) -->
	verb(Number, V),
	noun_phrase(_, NP),
	adverb(Adv).
verb_phrase(Actor, Number, event(V, [actor(Actor), object(NP), PP])) -->
	verb(Number, V),
	noun_phrase(_, NP),
	pp(Number, PP).
verb_phrase(Actor, Number, event(V, [actor(Actor), PP])) -->
	verb(Number, V),
	pp(_, PP).

pp(_, PP) --> prep(NP, PP), noun_phrase(_, NP).

% The next set of rules represent the lexicon

prep(NP, object(NP)) --> [of].
prep(NP, object(NP)) --> [to].
prep(NP, instrument(NP)) --> [with].
prep(NP, object(NP)) --> [in].
prep(NP, object(NP)) --> [for].

determiner(singular, det(a)) --> [a].
determiner(_, det(the)) --> [the].
determiner(plural, det(those)) --> [those].
determiner(_, _) --> [].

pronoun(singular, masculine, he) --> [he].
pronoun(singular, feminine, she) --> [she].
pronoun(singular, neutral, that) --> [that].
pronoun(plural, neutral, those) --> [those].
pronoun(singular, neutral, Pro) --> [Pro], {member(Pro, [i, someone, it])}.
pronoun(plural, neutral, Pro) --> [Pro], {member(Pro, [they, some])}.

possessive_pronoun(singular, masculine, his) --> [his].
possessive_pronoun(singular, feminine, her) --> [her].

prep(of) --> [of].
prep(to) --> [to].
prep(with) --> [with].
prep(in) --> [in].
prep(for) --> [for].

num(singular) --> [one].
num(plural) --> [two];[three];[four];[five];[six];[seven];[eight];[nine];[ten].

noun(singular, Noun) --> [Noun], {thing(Noun, Props), member(number(singular), Props)}.
noun(plural, Noun) --> [Noun], {thing(Noun, Props), member(number(plural), Props)}.

proper_noun(singular, Gender, Name) -->
	[Name],
	{
		thing(Name, Props), member(isa(person), Props), member(gender(Gender), Props)
	}.
proper_noun(singular, neutral, france) --> [france].

adjective(prop(Adj)) --> [Adj], {member(Adj, [red,green,blue])}.

verb(_, Verb) --> [Verb], {member(Verb, [lost,found,did,gave,looked,saw,forgot,is])}.
verb(singular, Verb) --> [Verb], {member(Verb, [scares,hates])}.
verb(plural, Verb) --> [Verb], {member(Verb, [scare,hate])}.

adverb([adv(too)]) --> [too].
adverb([]) --> [].

% You may chose to use these items in the database to provide another way
% of capturing an objects properties.

thing(john, [isa(person), gender(masculine), number(singular)]).
thing(sam, [isa(person), gender(masculine), number(singular)]).
thing(bill, [isa(person), gender(masculine), number(singular)]).
thing(jack, [isa(person), gender(masculine), number(singular)]).
thing(monet, [isa(person), gender(masculine), number(singular)]).

thing(mary, [isa(person), gender(feminine), number(singular)]).
thing(annie, [isa(person), gender(feminine), number(singular)]).
thing(sue, [isa(person), gender(feminine), number(singular)]).
thing(jill, [isa(person), gender(feminine), number(singular)]).

thing(wallet, [isa(physical_object), gender(neutral), number(singular)]).
thing(car, [isa(physical_object), gender(neutral), number(singular)]).
thing(book, [isa(physical_object), gender(neutral), number(singular)]).
thing(telescope, [isa(physical_object), gender(neutral), number(singular)]).
thing(pen, [isa(physical_object), gender(neutral), number(singular)]).
thing(pencil, [isa(physical_object), gender(neutral), number(singular)]).
thing(cat, [isa(physical_object), gender(neutral), number(singular)]).
thing(mouse, [isa(physical_object), gender(neutral), number(singular)]).
thing(man, [isa(physical_object), gender(neutral), number(singular)]).
thing(bear, [isa(physical_object), gender(neutral), number(singular)]).

thing(cats, [isa(physical_object), gender(neutral), number(plural)]).
thing(mice, [isa(physical_object), gender(neutral), number(plural)]).
thing(men, [isa(physical_object), gender(neutral), number(plural)]).
thing(bears, [isa(physical_object), gender(neutral), number(plural)]).

thing(capital, [isa(abstract_object), gender(neutral), number(singular)]).

thing(france, [isa(place), gender(neutral), number(singular)]).

event(lost, [actor(_), object(_), tense(past)]).
event(found, [actor(_), object(_), tense(past)]).
event(saw, [actor(_), object(_), tense(past)]).
event(forgot, [actor(_), object(_), tense(past)]).
event(scares, [actor(_), object(_), tense(present), number(singular)]).
event(scare, [actor(_), object(_), tense(present), number(plural)]).
event(hates, [actor(_), object(_), tense(present), number(singular)]).
event(hate, [actor(_), object(_), tense(present), number(plural)]).
event(gave, [actor(Person1), recipient(Person2), object(_), tense(past)]) :- Person1 \= Person2.

personal(i, [number(singular), gender(neutral)]).
personal(he, [number(singular), gender(masculine)]).
personal(she, [number(singular), gender(feminine)]).
personal(it, [number(singular), gender(neutral)]).
personal(that, [number(singular), gender(neutral)]).
personal(those, [number(plural), gender(neutral)]).
personal(they, [number(plural), gender(neutral)]).

possessive(his, [number(singular), gender(masculine)]).
possessive(her, [number(singular), gender(feminine)]).

% You have to write this:
% process(LogicalForm, Ref1, Ref2).
% process(event(Action, []), Ref1, []) :-
%     event_assert(event(Action, _)).
process(event(Action, [actor(Actor), object(Object)]), Ref1, Ref3) :- 
    process_actor(Actor, Ref1, Ref2),
    process_object(Object, Ref2, Ref3),
    event_assert(event(Action, [actor(Actor), object(Object)])).
    % X = new reference
    % append(Ref1, [X], Ref2), 
process_actor(thing(Name, []), _, _) :- 
    thing_assert(thing(Name, [])).
process_actor(set(Actor1, Actor2), _, _) :- 
    process_actor(Actor1, _, _),
    process_actor(Actor2, _, _),
    asserta(history(set(Actor1, Actor2))).
process_actor(personal(Pronoun), Ref1, Ref2) :-
    personal(Pronoun, Props1),
    member(number(plural), Props1),
    history(set(Thing1, Thing2)),
    append_set(Thing1, Thing2, [], RefSet),
    append(Ref1, [RefSet], Ref2).
process_actor(personal(Pronoun), Ref1, Ref2) :-
    search_personal(Pronoun, Ref1, Ref2).
process_actor(possessive(PPronoun, Actor), Ref1, Ref2) :-
    search_possessive(PPronoun, Ref1, Ref2),
    process_actor(Actor, Ref1, Ref2).

process_object(thing(Name, []), _, _) :- 
    thing_assert(thing(Name, [])).
process_object(thing(Name, [object(Object)]), _, _) :- 
    thing_assert(thing(Name, _)),
    process_object(Object, _, _).
process_object(personal(Pronoun), Ref1, Ref2) :-
    search_personal(Pronoun, Ref1, Ref2).
process_object(possessive(PPronoun, Object), Ref1, Ref2) :-
    search_possessive(PPronoun, Ref1, Ref2),
    process_object(Object, Ref1, Ref2).

thing_assert(thing(Name,_)) :-
    thing(Name, Props),
    assert(history(thing(Name,Props))).

event_assert(Event) :-
    assert(history(Event)).

search_personal(Pronoun, Ref1, Ref2) :-
    personal(Pronoun, Props1),
    search_append(Props1, Ref1, Ref2).

search_possessive(Pronoun, Ref1, Ref2) :-
    possessive(Pronoun, Props1),
    search_append(Props1, Ref1, Ref2).

search_append(Props1, Ref1, Ref2) :-
    member(gender(Gender), Props1),
    member(number(Number), Props1),
    history(thing(Ref, Props2)),
    member(gender(Gender), Props2),
    member(number(Number), Props2),
    append(Ref1, [Ref], Ref2).

append_set(thing(Name1, _), thing(Name2, _), Ref, RefSet) :-
    append(Ref, [Name1, Name2], RefSet).
append_set(thing(Name1, _), set(Thing1, Thing2), Ref, RefSet) :-
    append(Ref, [Name1], RefSet1),
    append_set(Thing1, Thing2, RefSet1, RefSet).

a :- abolish(history/1).
l :- listing(history/1).
n :- nodebug.
t :- trace.
r :- [ass3].

run(S, Refs) :-
	sentence(X, S, []), !,
	writeln(X),
	process(X, [], Refs),
    % writeln(Refs),
	listing(history/1).
    % abolish(history/1).

