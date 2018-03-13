type MARK = {subst, nadj, anchor, coanchor, lex, foot}
type CAT = {n, np,v,vp,s, pp, p, d, adj}
type PHON = {e}
type CASE = {nom, acc, obl}
type BOOL = {yes, no}
type NAME = {Kim, Sean}
type STATE = {raw, unwashed}
type KIND = {salad, apple, steak, can}

type BOT !
type LABEL !


property mark : MARK


%Syntactic Features
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

%Sean stomped the can flat.

%Kim eats the salad hungry. (subject oriented)
%Kim eats the salad raw.	(object oriented)

%Kim ate the apple unwashed.	(target ambiguity)

%%%%%%%%%%%%%%%%%%
% TREE FRAGMENTS %
%%%%%%%%%%%%%%%%%%

class VerbProjection
export ?VP ?V ?EV
declare  ?VP ?V ?EV
{
<syn> {
	node ?VP [e=?EV, cat=vp, aux = no];
	node ?V (mark=anchor)[cat=v]; 
        ?VP -> ?V
        };
<iface> {[e = ?EV]}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Subject[SubjMark]
export ?Ssubj ?NPsubj ?VPsubj ?A
declare ?Ssubj ?NPsubj ?VPsubj ?A
{ <syn>{
        node ?Ssubj [cat = s]{
                node ?NPsubj (mark = SubjMark) [i=?A, cat=np, case = nom]
                node ?VPsubj [cat = vp]
                }
        };
<iface> {[arg0 = ?A] }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Object[ObjCase, ObjMark]
export ?VPobj ?NPobj ?V ?B
declare ?VPobj ?NPobj ?V ?B 
{ <syn>{
        node ?VPobj [cat = vp];
        node ?NPobj (mark = ObjMark) [i=?B, cat=np, case = ObjCase];
        node ?V [cat=v];
        ?VPobj -> ?NPobj;   ?VPobj -> ?V; ?V >>+ ?NPobj
        };
<iface> {[arg1 = ?B] }

}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class OblObj[OblMark] %This class is necessary to prevent node unification in constructions containing two NP objects.
import VerbProjection[]
export ?Obl ?C
declare ?Obl ?C
{
	<syn> {
		 ?Obl = Object[obl, OblMark]; %Node disambiguation via class call
		 ?Obl.?VPobj = ?VP;
		 ?Obl.?V = ?V
	};
	<iface> {[arg2 = ?C]}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Nouns 
export ?NP ?N ?X0 ?X1
declare ?NP ?N ?WH ?D ?C ?X0 ?X1
{ <syn>{
  node ?NP [i= ?X0, cat=np, bot=[dp = ?D] , case=?C, wh=?WH] { 
  node ?N (mark=anchor) [i= ?X1, cat= n, dp = ?D, case=?C, wh=?WH] }
 };
 <iface>{[i=?X0]}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class determiner[Def]
export ?NP1 ?NP2 ?Det ?Def ?C
declare ?NP1 ?NP2 ?Det ?Def ?C
{<syn>{node ?NP1 [cat=np,dp=yes, def= Def,  case=?C]{
						node ?Det (mark=anchor) [cat=d, def=Def] ,,,+
					  node ?NP2 (mark=foot) [cat=np, dp=no,  case=?C]
			}
	}
}

class definite_determiner
import determiner[yes]

class indefinite_determiner
import determiner[no]



%%%%%%%%%%%%%%%%%%
% TREE TEMPLATES %
%%%%%%%%%%%%%%%%%%
class alphanx0V
import VerbProjection[] Subject[subst]
	{
		?VP = ?VPsubj		
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class alphanx0Vnx1
import alphanx0V[] Object[acc, subst]
declare ?X ?Y ?Z 
	{
	 ?VP = ?VPobj;
		<iface>{[e=?Z, arg0= ?X, arg1= ?Y]};
		<frame>{?Z[event, actor: ?X, undergoer: ?Y]}
	}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class ditransitive_ObliqueNP[OblMark]
import OblObj[OblMark]
export ?NPobj
declare ?NPobj
{
		<syn> {
		?Obl.?NPobj >>+ ?NPobj
					}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class alphanx0Vnx2nx1
import alphanx0Vnx1[] ditransitive_ObliqueNP[subst]


%%%%%%%%%%%%%%%%%
% TREE FAMILIES %
%%%%%%%%%%%%%%%%%

class Intrans
%import alphanx0V[] | alphaW0nx0V[]
export ?Tree
declare ?Tree
{
  ?Tree = alphanx0V[] 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Trans
export ?Tree
declare ?Tree
{
  ?Tree = alphanx0Vnx1[] 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Ditrans
export ?Tree
declare ?Tree
{
  ?Tree = alphanx0Vnx2nx1[] 
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Determiners
export ?Tree
declare ?Tree
{
	?Tree = definite_determiner[] | indefinite_determiner[]
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class Depictives
export ?DepVP0 ?DepVP1 ?DepAdj ?DepI
declare ?DepVP0 ?DepVP1 ?DepAdj ?DepI
{
 <syn> {
		node ?DepVP0 [e=?DepI, cat=vp] {...+
				node ?DepVP1(mark = foot)[e=?DepI, cat=vp]
				node ?DepAdj (mark = anchor)[cat = adj]
		}
	};
 <iface> {[e=?DepI]};
 <frame> {?DepI[event]}
	}

% %%%%%%%%%%%%%%%
% % EVALUTATION %
% %%%%%%%%%%%%%%%

% value Subject
% value Object
% value WhObject
% value ExtractionTrace
% value WhSubject
% value Vaux
% value PPObject

% %Intransitive + Wh
% value alphanx0V
% value alphaW0nx0V

% %Transitive + Wh
% value alphanx0Vnx1
% value alphaW0nx0Vnx1
% value alphaW1nx0Vnx1

% %Ditransitive + Wh
% value alphanx0Vnx2nx1
% value alphaW0nx0Vnx2nx1
% value alphaW1nx0Vnx2nx1
% value alphaW2nx0Vnx2nx1

value Nouns

value Determiners
value Depictives

value Intrans
value Trans
value Ditrans

% TODO: prenominal Adjectives