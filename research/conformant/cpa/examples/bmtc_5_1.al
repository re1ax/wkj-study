fluent dunked(1);
fluent armed(1);
fluent dunked(2);
fluent armed(2);
fluent dunked(3);
fluent armed(3);
fluent dunked(4);
fluent armed(4);
fluent dunked(5);
fluent armed(5);
fluent clogged(1);

flush(1) causes -clogged(1);

executable dunk(1,1) if -dunked(1), -clogged(1);
dunk(1,1) causes -armed(1),dunked(1),clogged(1);

executable dunk(2,1) if -dunked(2), -clogged(1);
dunk(2,1) causes -armed(2),dunked(2),clogged(1);

executable dunk(3,1) if -dunked(3), -clogged(1);
dunk(3,1) causes -armed(3),dunked(3),clogged(1);

executable dunk(4,1) if -dunked(4), -clogged(1);
dunk(4,1) causes -armed(4),dunked(4),clogged(1);

executable dunk(5,1) if -dunked(5), -clogged(1);
dunk(5,1) causes -armed(5),dunked(5),clogged(1);

initially armed(1);
initially armed(2);
initially armed(3);
initially armed(4);
initially armed(5);
initially clogged(1);

goal -armed(1);
goal -armed(2);
goal -armed(3);
goal -armed(4);
goal -armed(5);
