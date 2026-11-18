% shae-prolog-family-tree — src/family.pl
%
% A family-tree reasoning system in Prolog.
%
% Facts: parent/2, male/1, female/1
% Rules: mother/2, father/2, sister/2, brother/2, aunt/2, uncle/2,
%        grandparent/2, ancestor/2, cousin/2, siblings/2
%
% Sample family: 12 people across 3 generations.
%
% Requires SWI-Prolog or GNU Prolog to run (not available locally).
%
% Usage:
%   swipl -f src/family.pl
%   gprolog --consult-file src/family.pl
%
% Example queries (enter at the Prolog prompt):
%   ?- mother(mary, michael).
%   ?- father(john, susan).
%   ?- sister(susan, michael).
%   ?- brother(michael, susan).
%   ?- aunt(susan, alice).
%   ?- uncle(david, bob).
%   ?- grandparent(john, alice).
%   ?- ancestor(mary, dan).
%   ?- cousin(alice, carol).
%   ?- siblings(alice, bob).
%   ?- ancestor(john, Who).

%%--------------------------------------------------------------------
%% Generation 1 — grandparents
%%--------------------------------------------------------------------
male(john).
female(mary).

male(robert).
female(linda).

%%--------------------------------------------------------------------
%% Generation 2 — parents
%%--------------------------------------------------------------------
male(michael).
female(susan).

male(david).
female(karen).

%%--------------------------------------------------------------------
%% Generation 3 — grandchildren
%%--------------------------------------------------------------------
female(alice).
male(bob).
female(carol).
male(dan).

%%--------------------------------------------------------------------
%% parent/2 facts: parent(Parent, Child)
%%--------------------------------------------------------------------
% John & Mary are the parents of Michael and Susan.
parent(john, michael).
parent(mary, michael).
parent(john, susan).
parent(mary, susan).

% Robert & Linda are the parents of David and Karen.
parent(robert, david).
parent(linda, david).
parent(robert, karen).
parent(linda, karen).

% Michael & Susan are the parents of Alice and Bob.
parent(michael, alice).
parent(susan, alice).
parent(michael, bob).
parent(susan, bob).

% David & Karen are the parents of Carol and Dan.
parent(david, carol).
parent(karen, carol).
parent(david, dan).
parent(karen, dan).

%%--------------------------------------------------------------------
%% Rules
%%--------------------------------------------------------------------

% mother(Mother, Child) — Mother is female and a parent of Child.
mother(M, C) :- female(M), parent(M, C).

% father(Father, Child) — Father is male and a parent of Child.
father(F, C) :- male(F), parent(F, C).

% sibling(X, Y) — X and Y share a parent and are distinct people.
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

% siblings/2 — public alias for sibling/2.
siblings(X, Y) :- sibling(X, Y).

% sister(Sister, Sibling) — Sister is female and shares a parent.
sister(S, Sib) :- female(S), sibling(S, Sib).

% brother(Brother, Sibling) — Brother is male and shares a parent.
brother(B, Sib) :- male(B), sibling(B, Sib).

% grandparent(Grandparent, Grandchild) — parent of a parent.
grandparent(GP, GC) :- parent(GP, P), parent(P, GC).

% ancestor(Ancestor, Descendant) — direct or indirect parent.
ancestor(A, D) :- parent(A, D).
ancestor(A, D) :- parent(A, Z), ancestor(Z, D).

% aunt(Aunt, NieceNephew) — female sibling of one of the person's parents.
aunt(A, N) :- female(A), sibling(A, P), parent(P, N).

% uncle(Uncle, NieceNephew) — male sibling of one of the person's parents.
uncle(U, N) :- male(U), sibling(U, P), parent(P, N).

% cousin(Cousin1, Cousin2) — their parents are siblings, distinct people.
cousin(C1, C2) :- parent(P1, C1), parent(P2, C2), sibling(P1, P2), C1 \= C2.
