% Base cases that you should be able to handle
run([john,lost,his,wallet], Refs).
Refs = [John].
run([john,lost,her,wallet], Refs).
false.
run([mary,lost,her,wallet], Refs).
Refs = [mary].
run([she,looked,for,it], Refs).
Refs = [mary, wallet].

abolish(history/1).    % making sure the history has been reset for the next example.
run([mary,lost,her,wallet], Refs).
Refs = [mary].
run([he,looked,for,it], Refs).        % No male person in history
false.
run([john,looked,for,it], Refs).    % Now there is
Refs = [wallet].
run([he,found,it], Refs).
Refs = [john, wallet].

% Some more complicated examples
abolish(history/1).
run([mary,gave,the,wallet,to,john], Refs).
Refs = [].
run([he,lost,it], Refs).
Refs = [john, wallet].
run([john,and,mary,looked,for,it], X).
Refs = [wallet].
run([they,found,it], Refs).
Refs = [[john, mary], wallet].