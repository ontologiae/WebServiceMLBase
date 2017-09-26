Chiffrages

La base à lire :
Modèle COCOMO : http://fr.wikipedia.org/wiki/COCOMO

KLS = nombre de milliers de ligne du code source.
LA formule à avoir en tête : Effort en mois.homme = 2,4 * KLS^1,12 pour une complexité moyenne ( 2,4 * KLS^1,05) pour une complexité simple.

Bien que ce modèle soit vieux, j'ai pu constater, qu'à 15% près il était dans le juste en ce qui concerne mon projet.

Expressivité du code :
1 ligne de OCaml = 2 à 2.5 ligne de java (chiffre constaté en moyenne)


Lors de notre développement, j'ai mis au point un système de message décrit ici : https://linuxfr.org/users/montaigne/journaux/une-structure-de-donnees-generique
J'ai fait écrire par un de mes devs une librairie JS qui était capable de traiter ces messages traduits en JSON. Cela nous a couté 7
jours.Homme dont 2 de conception
Rétropédalage en OCaml, car trop compliqué à gérer en JS : 6h. On a donc ici un rapport de (7*8)/6 = 9

Pour avoir réalisé quelques réécriture en OCaml (passage du code côté client vers le serveur), on constate un rapport de 1 à 4 heure.homme
en faveur de OCaml. La raison en est simple : si l'écriture du code est légèrement plus pénible en JS, elle reste sensiblement la même dans
la plupart des cas grâce à la librairie Underscore qui permet de disposer de toute une librairie de fonction purement fonctionnel (map,
fold, filter, etc...), le debug est extrêmement couteux en JS où l'on est obligé de faire du pas à pas systématique.
Plus généralement, c'est le pattern matching qui est la clé de la productivité de OCaml.






Tout ce que je décrit dans ce paragraphe sur les modèles économiques à été soumis à mes profs de gestion à la fac et confirmé par eux (ceux-ci m'ont ouvert les yeux et  bien vite fait perdre mes
illusions...)


Modèle économique de la SSII :
- Marger sur de la vente de jour.homme en volume
==> La productivité n'est pas essentiellement recherché, et même dérangeante : imaginons que la SSII Tartampion utilise OCaml, le projet
divise son nombre de jour.homme par 2, le volume est divisé de tout autant, la marge sur coût variable n'augmente pas, par contre la marge
sur coût fixe chute. L'actionnaire n'est pas content car l'Excédent Brut d'Exploitation (EBE) chute.
De plus, les logiciels OCaml étant peu buggué, aucune chance de vendre de la Tierce Maintenance Applicative (contrat dans lequel la SSII
corrige au fil de l'eau les bugs de l'application qui vie en production). Une TMA peut occuper de 10 ingénieurs à une centaine pendant
plusieurs années (C'était le cas d'une TMA du logiciel de gestion client d'EDF, à laquelle j'ai participé).
À 400 euros le jour.homme, la facture grimpe vite.

Soyons plus cynique mais néanmoins totalement réaliste : est-ce à dire qu'une SSII a intérêt à vendre des logiciels buggués ?
Oui et non. Pour faire une analogie je vais reprendre le sketch de Coluche "Le délégué syndical", en surlignant les passages clés :

"Alors dejà dans la vie, peinard, et alors au boulot maintenant, j'suis syndiqué.
Je suis t'a F.O., Force ouvrière. Gardez vos forces, les ouvriers ! F.O., c'est sérieux comme syndicat.
- "F.O., voilà un syndicat qu'il est beau ! F.O., le syndycat qu'il vous faut !"
C'est un syndicat qu'est très bien parce qu'il est le plus petit.
>>>>> C'est celui qui fait le moins grève... donc, on gagne plus.
>>>>> Quand on est obligé, on la fait, parce que sans ça, ça se verrait...
Mais c'est toujours nous qu'on reprend le boulot le plus vite, hein !
Je vois à mon usine on est sept.
C'est le plus petit, comme syndicat, c'est le plus petit.
Alors il est un peu sur la corde raide.
>>>>> Si il penche trop du côté des ouvriers, les patrons payent plus.
>>>>> Et puis si il penche trop du côté des patrons, ça va finir par se voir !
Vu que c'est eux qui payent, et c'est pas le but de la manoeuvre !"


La SSII est dans la même situation : elle négocie avec le client un "niveau de bugs" acceptable lorsqu'elle reçoit le logiciel. Ca se
traduit par un nombre d'anomalie détectées par le client par rapport à la spec. Si ce nombre excède celui défini par contrat, la SSII paye
des pénalités.
Si le logiciel est trop bogué, le client peut être tenté d'aller voir ailleurs. Si le logiciel est nickel, la SSII scie la branche sur
laquelle est est assise car elle va pas vendre de TMA..

Conlusion : l'ensemble des SSII trouvent un point d'équilibre mutuel, qui leur permet de se partager le marché, de faire vivre tout le monde
en simulant plus ou moins une concurrence, mais en veillant à rester dans un même niveau de prix et de qualité.
Trop de qualité tue la poule aux oeufs d'or, pas assez attire les foudre du client.
Le modèle de la SSII est de justifier le fait de devoir embaucher plein de développeurs, ce qui arrange tout le monde, car ça génère des
emplois.

C'est la raison pour laquelle les SSII utilisent des technos comme Java ou PHP.
Cela permet de recruter des devs niveau BAC ou BAC+2.
Lorsque je travaillais à Accenture, on nous expliquait benoitement, que la pyramide de compétence de la boite devait être :
30% de niveau BAC
25% de niveau BAC
25% d'ingénieurs
15% d'ingénieurs expérimenté (bref ceux qui aurait le niveau de faire du OCaml)
2,5% de chefs de projet
1,5% de Directeurs de projet
1% pour le staff (Direction, RH, etc...)

A Accenture ils en sont au point où ils essayent de tout délocaliser à Maurice, car le dev leur coute 30 euros/jour (qu'il refacture 200 au
client).
Bienvenue dans un monde de requins.

Seul les cas où on a besoin de langage sûrs (aéronautique, automobile) justifient économiquements d'utiliser une techno comme OCaml.



Modèle économique de l'éditeur:
- Modèles plus divers, la plupart vendent des licences ou de la locations. Certaines vendent cher le support, donc leur logiciel buggué est
  un intérêt pour elle (cas 1), surtout si elle arrive à enfermer leur client (ce qui est souvent le cas), d'autres ont intérêts à avoir un logiciel
de qualité (cas 2) car le support est un coût (support illimité fourni avec la licence logiciel)

Modèle économique du fournisseur de service basé sur un logiciel :
- Le développement est un coût, le minimiser est intéressant car il augmente la marge opérationnelle de l'entreprise.
- Se fiche de la techno utilisée, l'importance est de pouvoir trouver facilement des compétences interchangeable et/ou de les former
  facilement. Il est aussi important d'avoir une techno sur lequel il existe une communauté active.


Les modèles économique de l'éditeur en cas 2 et du fournisseur de service peut attirer des gens vers la techno OCaml.
Vous remarquerez que c'est plus ou moins les modèles de Lexifi et Janet Street ou encore Citrix...
Et c'est là que OCamlPro est stratégique et a une importance fondamentale, car cela sécurise une entreprise qui sait :
- Qu'elle pourra compter sur OcamlPro pour former un dev à OCaml en cas de problème interne
- Qu'elle a une boite privé (donc qui comprend ses besoins, en entreprise on se méfie des universitaires) qui peut lui apporter du support
  en cas de problème.




Maintenant, reprenons le "Model of Software Acceptance" de Richard P. Gabriel (voir mon mémoire pour une longue description de son modèle,
et analysons OCaml.


OCaml:
• Technological model:
	✓ Old technology: assez vieux (1985-1990)
	✗ Tried before: pas vraiment
	✓ Appeals to market need: Dans certaines niches seulement (aéronautique, calcul symbolique)
	✗ Smallest investment: Pas du tout ! Former une compétence OCaml requiert un ingénieur et il est long à former
	✗ Minimize typing: Oui
• Design model:
	✗ Simplicity: Non, la compilation est à peine moins chiante qu'en C malgré les outils (ocamlfind, ocamlbuild)
	✗ Minimal completeness: Oui
	✗ Minimal correctness: Oui
	✗ Minimal consistency: Oui
	✗ Minimal abstraction: Non !!!!!
• Implementation: 
	✗ Fast: Oui
	✗ Small: Pas vraiment
	✓ Interoperate: Assez, sous Unix essentiellement
• Environment:
	✓ Cultural change: Non, à part la complexification des besoins logiciels qui évolue lentement, et encore dans quelques niches, aucun
changement d'environnement
	✓ Quickly adapted: yes
	✓ Gambler’s Ruin-safe: Oui

• Language requirements:
	✓ Runs everywhere: Oui
	✗ Minimal computer requirements: Maintenant, non, ça tourne même sur un téléphone
	✗ Simple performance model: Dans l'ensemble, oui
	✗ Minimal mathematical sophistication: Non !!! Les concepts de polymorphisme, d'ordre supérieur, je met des mois à l'apprendre à un
développeur déjà compétent.
	✓ Minimally acceptable for purpose: sort of 
	✗ Similar to popular language: La plupart des langages pourris (genre PHP ou Java) commencent à penser à mettre des closure, donc ça
progresse lentement
	✓ Gurus: yes


Conclusion : A part enseigner OCaml en premier (avant un langage impératif) et veiller à ce que l'enseignement soit sympa, ça va être dur.
90% des gens que je croise et me disent qu'ils ont fait du OCaml (à la fac ou en école d'ingénieur) m'explique qu'on les a dégoutés de ce
langage (et du fonctionnel). En général parce qu'on ne leur a fait faire que des trucs théoriques chiants.

Pour convaincre les éditeurs/fournisseurs de service, il faut leur démontrer que :
- Trouver/Former une ressource à OCaml n'est pas insurmontable
- Qu'elle va économiser drastiquement en jour.homme assez vite
- Qu'elle va donc améliorer fortement sa productivité et donc sa marge opérationelle.




-----------------------
COCOMO
Cout d'une ligne

Cout d'un cas ou le compilateur détecte le problème et le temps passer à la débugguer avec un traceur de code
Taux de bug de types, et de bug fonctionnels
