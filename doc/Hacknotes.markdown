Design notes
============

In planning the app, here is how I decided to model the resources and the
underlying data:

Talk
----

A Talk goes on in a Slot. Usually we would call this a Session. It is the thing
that happens when one or more people congregate in a place to discuss some
topic or the other. The reason I haven't called it a session is so that
programmers don't end up going completely mental as 'session' is used in a lot
of web frameworks (possibly including Rails) to refer to a user session where
they get a cookie and login and so on.

Slot
----

A Slot contains a Talk. A slot is contained in a Timeslot and optionally a Room.

Properties:
  * room (Room)
  * timeslot (Timeslot)
  * booked? (bool)
  * talk (Talk?)

Room
----

A Room is where a session takes place. It has a name and optionally a
description (for information such as "on the second floor" etc.)

2011-07-05 11:32 TM; I originally planned to create a shortcode for a room
based on the database ID. But I couldn't quite get it to work and databases
have funky ways of assigning IDs (e.g. SQLite) and being lazy I decided that
writing an algorithm for turning integers into strings based on database IDs
was stupid. Instead I've gone with a 'shortcode' system so you can assign a
very short ID to a room. I've also decided to use 'weighting' as a way of
ordering rooms in the table - so if you give room A a weighting of 1, leave
room B with a weighting of 0 and set room C with a weighting of -1, then they
would appear in the order〈A B C〉.

Timeslot
--------

A Timeslot is a set period of time when a session takes place. Slots are
created by taking the set of all timeslots and the set of all rooms and
combining each one in turn.

User
----

A human being who can create talks and put them in slots.
