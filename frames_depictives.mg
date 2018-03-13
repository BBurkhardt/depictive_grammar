type MARK = {subst, nadj, anchor, coanchor, lex, foot}
type CAT = {n, np,v,vp,s, pp, p, d, adj}
type PHON = {e}
type CASE = {nom, acc, obl}
type BOOL = {yes, no}
type NAME = {Kim, Sean}
type STATE = {raw, unwashed, hungry}
type KIND = {salad, apple, steak, can}

type BOT !
type LABEL !


property mark : MARK


%Syntactic Features
feature cat : CAT
feature phon : PHON
feature case : CASE
feature cat : CAT
feature phon : PHON
feature case : CASE
feature trace : TRACE
feature aux : BOOL
feature wh : BOOL
feature dp : BOOL
feature def : BOOL
feature bot : BOT

%Interface Features
feature arg0 : LABEL
feature arg1 : LABEL
feature arg2 : LABEL
feature i : LABEL
feature e : LABEL


frame-types = {event, activity, eating, stomping, entity, physical_object, edible, person, actor, undergoer, agent, theme, manner} 
frame-constraints = {
% Subtyping:
activity -> event,
eating -> activity,
stomping -> activity,
person -> entity,
physical_object -> entity,
edible -> physical_object,
% Frame type compatibility:
edible person -> - ,
physical_object person -> - ,
% Attribute constraints
person ->  name: +,
person -> state: +,
edible -> state: +
}



%%% TODO: Stomping

%%%%%%%%%%
% Frames %
%%%%%%%%%%
%%proper nouns
class frameKim
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[entity,
			name: Kim
			]
	}
}

class frameSean
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[person,
				name: Sean
			]
	}
}

%%Nouns
class frameApple
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[edible,
			kind: apple ]
	}
}

class frameSteak
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[edible,
			kind: steak ]
	}
}

class frameSalad
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[edible,
			kind: salad]
	}
}

class frameCan
declare ?X0
{
 <iface> {[i=?X0]};
 <frame> {
		?X0[physical_object,
			kind: can]
	}
}

%%Verbs
class frameEat
declare ?X0 ?X1 ?X2
{
  <iface>{[e=?X0, arg0=?X1, arg1=?X2]};
  <frame>{
    ?X0[eating,
			agent :?X1[person], 
			theme :?X2[edible],
			actor: ?X1,
			undergoer: ?X2]
  }
}

class frameStomp
declare ?X0 ?X1 ?X2
{
  <iface>{[e=?X0, arg0=?X1, arg1=?X2]};
  <frame>{
    ?X0[eating,
			agent :?X1[person], 
			theme :?X2[physical_object],
			actor: ?X1,
			undergoer: ?X2]
  }
}


%%Depictives
class frameHungry 
declare ?X0
{
 <iface> {[e=?X0]};
 <frame> {	?X0[event, actor : [person, state: hungry]]
					|
					?X0[event,undergoer : [person, state: hungry]]
	}
}

class frameRaw
declare ?X0
{
 <iface> {[e=?X0]};
 <frame> {	?X0[event,undergoer : [edible, state: raw]]
			|
			?X0[event, actor : [edible, state: raw]]
	}
}


class frameUnwashed
declare ?X0
{
 <iface> {[e=?X0]};
 <frame> {?X0[event, actor : [person, state: unwashed]]
				|
				?X0[event, undergoer : [person, state: unwashed]]
	}
}

%%%%%%%%%%%%%%
% Evaluation %
%%%%%%%%%%%%%%

value frameKim
value frameSean

value frameApple
value frameSalad
value frameCan
value frameSteak

value frameEat
value frameStomp

value frameRaw
value frameUnwashed
value frameHungry