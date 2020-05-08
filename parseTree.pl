sentence(sentence(NP, VP)) -->
    noun_phrase(Number, NP),
    verb_phrase(Number, VP).
noun_phrase(Number, noun_phrase(Det, Noun)) -->
    determiner(Det),
    noun(Number, Noun).
verb_phrase(Number, verb_phrase(V, NP)) -->
    verb(Number, V),
    noun_phrase(_, NP).

determiner(determiner(a)) --> [a].
determiner(determiner(the)) --> [the].

noun(singular, noun(cat)) --> [cat].
noun(plural, noun(cats)) --> [cats].
noun(singular, noun(mouse)) --> [mouse].
noun(plural, noun(mice)) --> [mice].

verb(singular, verb(scares)) --> [scares].
verb(singular, verb(hates)) --> [hates].
verb(plural, verb(hate)) --> [hate].

s([a, b|X], X).
s([a|X], Y) :-
    s(X, [b|Y]).