%% To be compiled with the mph compiler
%% xmg compile mph morph.mg



type CAT = {n, np,v,vp,s, pp, p, d, adj}
type BOOL = {yes, no}


feature morph: string
feature lemma: string
feature cat  : CAT
feature wh : BOOL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERBS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class ateEat
{
  <morpho> {
    morph <- "ate";
    lemma <- "eat";
    cat   <- v
   }
}

class eatsEat
{
  <morpho> {
    morph <- "eats";
    lemma <- "eat";
    cat   <- v
   }
}

class Eat
export ?morph
declare ?morph
{
 ?morph = ateEat[] | eatsEat[]	
}

class stompedStomp
{
  <morpho> {
    morph <- "stomped";
    lemma <- "stomp";
    cat   <- v
   }
}


class Verbs
export ?verb
declare ?verb
{
	?verb = Eat[] | stompedStomp[]
}

%%%%%%%%%
% Nouns %
%%%%%%%%%

% Factorization ahead
class Noun
export ?NMorph ?NLemma
declare ?NMorph ?NLemma
{
	<morpho> {
		morph <- ?NMorph;
		lemma <- ?NLemma;
    cat   <- n;
		wh <- no;
		dp <- no
	}
}

class apple
import Noun[]
{
  ?NMorph =  "apple";
  ?NLemma =  "apple"
}

class can
import Noun[]
{
  ?NMorph =  "can";
  ?NLemma =  "can"
}

class salad
import Noun[]
{
  ?NMorph =  "salad"; %| ?NMorph =  "Salad";
  ?NLemma =  "salad"
}

class steak
import Noun[]
{
  ?NMorph =  "steak"; %| ?NMorph =  "Steak";
  ?NLemma =  "steak"
}

class Nouns
export ?noun
declare ?noun
{
	 ?noun = apple[] | can[] | salad[] | steak[]
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
class properNoun
export ?NMorph ?NLemma
declare ?NMorph ?NLemma
{
  <morpho> {
    morph <- ?NMorph;
    lemma <- ?NLemma;
    cat   <- n;
		wh <- no;
		dp <- yes
   }
}

class Kim
import properNoun[]
{
  ?NMorph =  "Kim";
  ?NLemma =  "kim"
}

class Sean
import properNoun[]
{
  ?NMorph =  "Sean";
  ?NLemma =  "sean"
}

class Names
export ?name
declare ?name
{
	?name = Kim[] | Sean[]
}

%%%%%%%%%%%%%%%
% Determiners %
%%%%%%%%%%%%%%%
class det[Def]
export ?DMorph ?DLemma
declare ?DMorph ?DLemma
{
	<morpho> {
		morph <- ?DMorph;
		lemma <- ?DLemma;
		cat <- d;
		def <- Def
	}
}

class the
import det[yes]
{
	?DMorph = "the";
	?DLemma = "the"
}

class a
import det[no]
{
	?DMorph = "a";
	?DLemma = "a"	
}

class an
import det[no]
{
	?DMorph = "an";
	?DLemma = "a"	
}

class Determiners
export ?Determiner
declare ?Determiner
{
	?Determiner = the[] | a[] | an[]
}

%%%%%%%%%%%%%%
% Adjectives %
%%%%%%%%%%%%%%

class adjective[]
export ?AdjMorphLemma
declare ?AdjMorphLemma
{
	<morpho> {
		morph <- ?AdjMorphLemma;
		lemma <- ?AdjMorphLemma;
		cat <- adj
	}
}

class flat
import adjective[]
{
	?AdjMorphLemma = "flat"
}

class hungry
import adjective[]
{
	?AdjMorphLemma = "hungry"
}

class raw
import adjective[]
{
	?AdjMorphLemma = "raw"
}

class unwashed
import adjective[]
{
	?AdjMorphLemma = "unwashed"
}

class Adjectives
declare ?Adjective
{
	?Adjective = hungry[] | raw[] | unwashed[] %| flat[]
}

%%%%%%%%%%%%%%%
% EVALUTATION %
%%%%%%%%%%%%%%%

value Verbs

value Nouns

value Names

value Determiners

value Adjectives
