sentence(VP) -->
    noun_phrase(Actor),
    verb_phrase(Actor, VP).

noun_phrase(NP) -->
    proper_noun(NP).

verb_phrase(Actor, VP) -->
    intrans_verb(Actor, VP).
verb_phrase(Subject, VP) -->
    trans_verb(Subject, Object, VP),
    noun_phrase(Object).

intrans_verb(Actor, paints(Actor)) --> [paints].
trans_verb(Subject, Object, likes(Subject, Object)) --> [likes].

proper_noun(john) --> [john].
proper_noun(annie) --> [annie].