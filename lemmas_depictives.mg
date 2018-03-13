%% To be compiled with the lex compiler
%% xmg compile lex THISFILEsNAME.mg

type CAT = {n, np,v,vp,s, pp, p, d, adj}
type FAM = {Intrans, Trans, Dirtans, Nouns, Determiners, Depictives}
type SEM = {frameKim, frameSean, frameApple, frameSalad, frameCan, frameEat, frameRaw}

feature entry: string
feature cat: CAT
feature fam: FAM

%%%%%%%%%%%%%%%%
% Proper Nouns %
%%%%%%%%%%%%%%%%

class lemmaKim
{
	<lemma> {
		entry <- "kim";
		cat <- n;
		fam <- Nouns;
		sem <- frameKim
	}
}

class lemmaSean
{
	<lemma> {
		entry <- "sean";
		cat <- n;
		fam <- Nouns;
		sem <- frameSean
	}
}

%%%%%%%%%
% Nouns %
%%%%%%%%%

class lemmaNoun[Frame]
export ?Entry
declare ?Entry
{
	<lemma> {
		entry <- ?Entry;
		cat <- n;
		fam <- Nouns;
		sem <- Frame
	}
}

class lemmaApple[]
import lemmaNoun[frameApple]
{
	?Entry = "apple"
}

class lemmaCan[]
import lemmaNoun[frameCan]
{
	?Entry = "can"
}

class lemmaSalad
import lemmaNoun[frameSalad]
{
	?Entry = "salad"
}

class lemmaSteak[]
import lemmaNoun[frameSteak]
{
	?Entry = "steak"
}

%%%%%%%%%%%%%%%
% Determiners %
%%%%%%%%%%%%%%%

class lemmaDeterminer
export ?Entry
declare ?Entry
{
	<lemma> {
    entry <- ?Entry;
    cat   <- d;
    fam   <- Determiners
	}
}

class lemmaA
import lemmaDeterminer[]
{
	?Entry = "a"
}

class lemmaThe
import lemmaDeterminer[]
{
	 ?Entry = "the"
}

%%%%%%%%%
% Verbs %
%%%%%%%%%

class lemmaVerb[Fam, Frame]
export ?Entry 
declare ?Entry 
{
	<lemma> {
    entry <- ?Entry;
    cat   <- v;
    fam   <- Fam;
		sem <- Frame
	}
}

class lemmaEat
import lemmaVerb[Trans, frameEat]
{
	?Entry = "eat"
}

class lemmaStomp
import lemmaVerb[Trans, frameStomp]
{
	?Entry = "stomp"
}

%%%%%%%%%%%%%%
% Adjectives %
%%%%%%%%%%%%%%

class lemmaAdj[Frame]
export ?Entry 
declare ?Entry
{
 <lemma> {
	entry <- ?Entry;
	cat <- adj;
	fam <- Depictives; % | Adjectives
	sem <- Frame
	}
}

class lemmaFlat
import lemmaAdj[]
{
	?Entry = "flat"
}

class lemmaHungry
import lemmaAdj[frameHungry]
{
	?Entry = "hungry"
}

class lemmaRaw
import lemmaAdj[frameRaw]
{
	?Entry = "raw"
}

class lemmaUnwashed
import lemmaAdj[frameUnwashed]
{
	?Entry = "unwashed"
}



value lemmaKim
value lemmaSean

value lemmaApple
value lemmaCan
value lemmaSalad
value lemmaSteak

value lemmaA
value lemmaThe

value lemmaEat
value lemmaStomp

%value lemmaFlat
value lemmaHungry
value lemmaRaw
value lemmaUnwashed

