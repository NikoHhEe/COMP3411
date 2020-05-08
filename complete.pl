?- op(700, xfy, &).
?- op(800, xfy, ->).
determiner(X, Property, Assertion, all(X, (Property -> Assertion))) --> [every].
determiner(X, Property, Assertion, exists(X, (Property & Assertion))) --> [a].

noun(X, man(X)) --> [man].
noun(X, woman(X)) --> [woman].
noun(X, person(X)) --> [person].

proper_noun(john) --> [john].
proper_noun(annie) --> [annie].
proper_noun(monet) --> [monet].

trans_verb(X, Y, likes(X, Y)) --> [likes].
trans_verb(X, Y, admires(X, Y)) --> [admires].

intrans_verb(X, paints(X)) --> [paints].

sentence(S) -->
    noun_phrase(X, Assertion, S),
    verb_phrase(X, Assertion).

noun_phrase(X, Assertion, S) -->
    determiner(X, Property12, Assertion, S),
    noun(X, Property1),
    rel_clause(X, Property1, Property12).
noun_phrase(X, Assertion, Assertion) -->
    proper_noun(X).

verb_phrase(X, Assertion) -->
    trans_verb(X, Y, Assertion1),
    noun_phrase(Y, Assertion1, Assertion).
verb_phrase(X, Assertion) -->
    intrans_verb(X, Assertion).

rel_clause(X, Property1, (Property1 & Property2)) -->
    [that],
    verb_phrase(X, Property2).
rel_clause(_, Property, Property).