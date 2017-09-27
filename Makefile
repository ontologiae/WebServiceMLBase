#ATD= $(wildcard DefinitionTypes/*.atd)

atd:
	echo param=$^

copyatds: 
	cp  DefinitionTypes/*.atd .
	$(eval TOTO := $(wildcard *.atd) )
	


rmatds :
	rm *.atd




atds: copyatds
	$(eval TOTO := $(wildcard *.atd) )
	for i in *.atd ; do atdgen -t $$i ; atdgen -j -std-json $$i ; done
	#$(foreach EL, $(TOTO),  atdgen -t $(EL); atdgen -j -std-json $(EL); )


types: rmatds
	for i in *_t.mli ; do ocamlfind ocamlopt -c -g $$i  -package atdgen; done
	for i in *_j.mli ; do ocamlfind ocamlopt -c -g $$i  -package atdgen; done
	for i in *_t.ml ;  do ocamlfind ocamlopt -c -g $$i  -package atdgen; done
	for i in *_j.ml ;  do ocamlfind ocamlopt -c -g $$i  -package atdgen; done





typesbyte: rmatds
	for i in *_t.mli ; do ocamlfind ocamlc -c -g $$i  -package atdgen; done
	for i in *_j.mli ; do ocamlfind ocamlc -c -g $$i  -package atdgen; done
	for i in *_t.ml ;  do ocamlfind ocamlc -c -g $$i  -package atdgen; done
	for i in *_j.ml ;  do ocamlfind ocamlc -c -g $$i  -package atdgen; done


all: atds rmatds typesbyte
	ocamlfind ocamlc -c  -g Template_Email_Cowebo.ml
	ocamlfind ocamlc -c -g  Cowebo_Erreurs.ml
	ocamlfind ocamlc -c -g Courriel_confirmation_compte_cree_par_autre_utilisateur.ml	
	ocamlfind ocamlc -c -g  -thread		Cowebo_Config.ml
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,cryptokit,batteries" Cowebo_Config.cmo Utils.ml
	ocamlfind ocamlc -c  -g -thread		Cowebo_Config.cmo Utils.cmo  Memcache.ml
	ocamlfind ocamlc -c  -g -warn-error "+8+11+14+20" -package batteries,netstring -thread Utils.cmo Classif_Tags.ml
	ocamlfind ocamlc -c  -g  -package "postgresql,cryptokit,batteries" -thread Cowebo_Config_t.cmo Cowebo_Config_j.cmo Memcache.cmo Cowebo_Config.cmo  BDD.ml	
	ocamlfind ocamlc -c  -g BDD.cmo ProfilUtilisateur.mli
	ocamlfind ocamlc -c  -g BDD.cmo ProfilUtilisateur.ml
				#ocamlfind ocamlc -i  -package "netstring,netclient,atdgen,rpc-ssl,extlib" AlfrescoTalking.ml > AlfrescoTalking.mli
	#ocamlfind ocamlc -c -verbose -g   -package "netstring,netclient,atdgen,rpc-ssl,extlib"  Utils.cmo *_j.cmo AlfrescoTalking.mli
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,netsys" BDD.cmo  Cowebo_Email.ml
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,netclient,atdgen,rpc-ssl,batteries"  Cowebo_Config.cmo Utils.cmo *_j.cmo Memcache.cmo BDD.cmo Classif_Tags.cmo AlfrescoTalking.ml
	ocamlfind ocamlc -c  -g -warn-error "+8+11+14+20"  -package "postgresql,cryptokit,batteries" -thread  BDD.cmo AlfrescoTalking.cmo  Cercle.ml
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,cryptokit,batteries"  -thread Utils.cmo   AlfrescoTalking.cmo CleRSA_t.cmo CleRSA_j.cmo  Certificat.ml
	ocamlfind ocamlc -c  -g  -package "atdgen,batteries,netstring-pcre" Utils.cmo Cowebo_Config_j.cmo BDD.cmo  Cowebo_CoffreFort.ml
	ocamlfind ocamlc -c  -g  -package "netstring,postgresql,cryptokit,batteries,netstring-pcre" -thread   Utils.cmo  Memcache.cmo  BDD.cmo Cowebo_securite.ml
	ocamlfind ocamlc -c  -g  -package "netstring,postgresql,cryptokit,batteries,netstring-pcre" -thread   Utils.cmo  Memcache.cmo  BDD.cmo Messages.ml
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,postgresql,cryptokit,batteries" -thread Contrat.ml
	ocamlfind ocamlc -c  -g  -package "netstring,netstring-pcre,postgresql,cryptokit,batteries" -thread TypesClementine_j.cmo Cowebo_Email.cmo Courriel_confirmation_compte.cmo Courriel_confirmation_compte_cree_par_autre_utilisateur.cmo Messages.cmo Cercle.cmo  Cowebo_Communaute.ml
	ocamlfind ocamlc -c  -g -package batteries ArborescenceCowebo_j.cmo ArborescenceCowebo_t.cmo AlfrescoTalking.cmo Messages.cmo ProfilUtilisateur.cmo Cowebo_Communaute.cmo Classif_Tags.cmo Arborescence.ml
	ocamlfind ocamlc -c  -g -package batteries ArborescenceCowebo_j.cmo ArborescenceCowebo_t.cmo AlfrescoTalking.cmo Messages.cmo Cowebo_Communaute.cmo SMS.ml
	ocamlfind ocamlc -c  -g  -package "netstring-pcre,netclient,atdgen,batteries" CleRSA_j.cmo CleRSA_t.cmo Certificat.cmo *.cmo Cowebo_Signature.ml
		#ocamlfind ocamlc -i  -package "netstring,netcgi2,netclient,nethttpd-for-netcgi2,atdgen,extlib"  BDD.cmo Cowebo_CGI.ml > Cowebo_CGI.mli
		#ocamlfind ocamlc -c -verbose -g   -package "netstring,netcgi2,netclient,nethttpd-for-netcgi2,atdgen,postgresql,cryptokit,extlib"  -thread *.cmo   Cowebo_CGI.mli
	ocamlfind ocamlc -c  -g   -package "netstring-pcre,netcgi2,netclient,nethttpd-for-netcgi2,atdgen,postgresql,cryptokit,batteries"  -thread Utils.cmo  Memcache.cmo  BDD.cmo Contrat.cmo Arborescence.cmo Cowebo_Signature.cmo ProfilUtilisateur.cmo Messages.cmo SMS.cmo Cowebo_Erreurs.cmo Cowebo_CGI.ml
	ocamlfind ocamlc -c  -g   -package "netstring-pcre,netstring,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,batteries" *.cmo Cowebo_MAIN.ml 
	ocamlfind ocamlc  -g  -o sign   -package "netstring-pcre,netstring,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,rpc-ssl,postgresql,cryptokit,batteries,batteries"     -thread -linkpkg *_t.cmo AddUtilisateur_in_j.cmo AddUtilisateur_out_j.cmo  TypesMandarine_j.cmo ArborescenceCowebo_j.cmo Cowebo_Config_j.cmo CreateFolder_j.cmo TypesClementine_j.cmo CreateUser_j.cmo CreationDossier_j.cmo CreerGroupeRacine_j.cmo DeleteFolder_j.cmo FileProperties_j.cmo Flexigrid_j.cmo GetFileAndFolder_j.cmo GetFolder_j.cmo GetGroupTree_j.cmo GroupInfo_j.cmo LsGroup_j.cmo MetaDataUserCwb_j.cmo MetaData_cwb_j.cmo MetadataCat_j.cmo MetadataEdit_j.cmo PortefeuilleElectronique_j.cmo ProprietesFichier_j.cmo  Upload_j.cmo UserInfo_j.cmo UserLs_j.cmo  FullContact_j.cmo Cowebo_Config.cmo Utils.cmo Memcache.cmo BDD.cmo Classif_Tags.cmo  ProfilUtilisateur.cmo   AlfrescoTalking.cmo Cercle.cmo   CleRSA_j.cmo  Certificat.cmo  Cowebo_CoffreFort.cmo Cowebo_securite.cmo Cowebo_Email.cmo  Contrat.cmo Template_Email_Cowebo.cmo Cowebo_Erreurs.cmo Messages.cmo Cowebo_Communaute.cmo Arborescence.cmo  SMS.cmo Cowebo_Signature.cmo  Cowebo_CGI.cmo  Cowebo_MAIN.cmo



doc : all
	rm -f doc/*
	ocamlfind ocamldoc -html -verbose -v -charset UTF-8 -package "batteries,netstring,netstring-pcre,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,rpc-ssl,postgresql,cryptokit" -d doc/ -I .Template_Email_Cowebo.ml Cowebo_Erreurs.ml  Cowebo_Config.ml Utils.ml Memcache.ml Classif_Tags.ml BDD.ml  Cercle.ml ProfilUtilisateur.ml Cowebo_Email.ml AlfrescoTalking.ml Cowebo_CoffreFort.ml Cowebo_securite.ml  Messages.ml  Contrat.ml  Cowebo_Communaute.ml SMS.ml  Cowebo_Signature.ml  Arborescence.ml  Cowebo_CGI.ml
	ocamlfind ocamldoc -dot -package "batteries,netstring,netstring-pcre,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,rpc-ssl,postgresql,cryptokit" -d doc/ -I .Template_Email_Cowebo.ml Cowebo_Erreurs.ml  Cowebo_Config.ml Utils.ml Memcache.ml Classif_Tags.ml BDD.ml  Cercle.ml ProfilUtilisateur.ml Cowebo_Email.ml AlfrescoTalking.ml Cowebo_CoffreFort.ml Cowebo_securite.ml  Messages.ml  Contrat.ml  Cowebo_Communaute.ml SMS.ml  Cowebo_Signature.ml  Arborescence.ml  Cowebo_CGI.ml -o Clementine.dot
	for i in doc/*.html ; do sed -i '' 's:iso-8859-1:UTF-8:' $$i ; done



base: atds types
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -thread Cowebo_Config.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  Cowebo_Erreurs.ml	
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -package "netstring,netstring-pcre,cryptokit,batteries" Cowebo_Config.cmx Utils.ml	
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -thread Cowebo_Config.cmx Utils.cmx  Memcache.ml
	ocamlfind ocamlopt -c  -g -warn-error "+11+14+20"  -package "postgresql,cryptokit,batteries" -thread Cowebo_Config_t.cmx Cowebo_Config_j.cmx Memcache.cmx Cowebo_Config.cmx  BDD.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "postgresql,cryptokit,batteries,netstring,netstring-pcre" -thread   Utils.cmx  Memcache.cmx  BDD.cmx Cowebo_securite.ml	
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,netclient,atdgen,batteries,ssl"  Cowebo_Config.cmx Utils.cmx *_j.cmx Memcache.cmx BDD.cmx Classif_Tags.cmx AlfrescoTalking.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,netcgi2,nethttpd,netclient,atdgen,postgresql,cryptokit,batteries"  -thread Utils.cmx Cowebo_Erreurs.cmx   Memcache.cmx  BDD.cmx  Cowebo_Erreurs.cmx Cowebo_CGI.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20"  -package "netstring,netcgi2,nethttpd,netplex,netclient,atdgen,batteries" *.cmx Cowebo_MAIN.ml 
	ocamlfind ocamlopt -g  -o   sign   -package "netstring,netstring-pcre,netcgi2,nethttpd,netplex,netclient,atdgen,postgresql,cryptokit,batteries"   -thread -linkpkg *_t.cmx AddUtilisateur_in_j.cmx AddUtilisateur_out_j.cmx  TypesMandarine_j.cmx  Cowebo_Config_j.cmx  TypesClementine_j.cmx  PortefeuilleElectronique_j.cmx  Cowebo_Config.cmx Utils.cmx Memcache.cmx BDD.cmx Cowebo_securite.cmx Cowebo_Erreurs.cmx  AlfrescoTalking.cmx  Cowebo_CGI.cmx  Cowebo_MAIN.cmx






sign:  atds types
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20" Template_Email_Cowebo.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  Cowebo_Erreurs.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -thread Cowebo_Config.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -package "netstring,netstring-pcre,cryptokit,batteries" Cowebo_Config.cmx Utils.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -thread Cowebo_Config.cmx Utils.cmx  Memcache.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -package batteries,netstring -thread Utils.cmx Classif_Tags.ml
	ocamlfind ocamlopt -c  -g -warn-error "+11+14+20"  -package "postgresql,cryptokit,batteries" -thread Cowebo_Config_t.cmx Cowebo_Config_j.cmx Memcache.cmx Cowebo_Config.cmx  BDD.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20" BDD.cmx ProfilUtilisateur.mli
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20" BDD.cmx ProfilUtilisateur.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netsys" BDD.cmx  Cowebo_Email.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,netclient,atdgen,rpc-ssl,batteries"  Cowebo_Config.cmx Utils.cmx *_j.cmx Memcache.cmx BDD.cmx Classif_Tags.cmx AlfrescoTalking.ml
	ocamlfind ocamlopt -c  -g -warn-error "+8+11+14+20"  -package "postgresql,cryptokit,batteries" -thread  BDD.cmx AlfrescoTalking.cmx Cercle.ml	
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,cryptokit,batteries"  -thread Utils.cmx   AlfrescoTalking.cmx CleRSA_t.cmx CleRSA_j.cmx  Certificat.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "atdgen,batteries,netstring,netstring-pcre" Utils.cmx Cowebo_Config_j.cmx BDD.cmx  Cowebo_CoffreFort.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "postgresql,cryptokit,batteries,netstring,netstring-pcre" -thread   Utils.cmx  Memcache.cmx  BDD.cmx Cowebo_securite.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "postgresql,cryptokit,batteries,netstring,netstring-pcre" -thread   Utils.cmx  Memcache.cmx  BDD.cmx Messages.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "postgresql,cryptokit,batteries,netstring,netstring-pcre" -thread   Utils.cmx  Memcache.cmx  BDD.cmx Contrat.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,postgresql,cryptokit,batteries" -thread  BDD.cmx Cowebo_Email.cmx Template_Email_Cowebo.cmx Messages.cmx ProfilUtilisateur.cmx Cercle.cmx Cowebo_Communaute.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package batteries ArborescenceCowebo_j.cmx ArborescenceCowebo_t.cmx Cowebo_Erreurs.cmx  AlfrescoTalking.cmx Messages.cmx Cowebo_Communaute.cmx Classif_Tags.cmx Arborescence.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package batteries ArborescenceCowebo_j.cmx ArborescenceCowebo_t.cmx Cowebo_Erreurs.cmx  AlfrescoTalking.cmx Messages.cmx Cowebo_Communaute.cmx SMS.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,netclient,atdgen,batteries" CleRSA_j.cmx CleRSA_t.cmx Certificat.cmx *.cmx Cowebo_Signature.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20" -package "netstring,netstring-pcre,netcgi2,netclient,nethttpd-for-netcgi2,atdgen,postgresql,cryptokit,batteries"  -thread Utils.cmx Cowebo_Erreurs.cmx   Memcache.cmx  BDD.cmx Arborescence.cmx Cowebo_Signature.cmx ProfilUtilisateur.cmx Messages.cmx  Contrat.cmx SMS.cmx Cowebo_Erreurs.cmx Cowebo_CGI.ml
	ocamlfind ocamlopt -c  -g  -warn-error "+8+11+14+20"  -package "netstring,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,batteries" *.cmx Cowebo_MAIN.ml 
	ocamlfind ocamlopt -g  -o   sign   -package "netstring,netstring-pcre,netcgi2,nethttpd-for-netcgi2,netplex,netclient,atdgen,rpc-ssl,postgresql,cryptokit,batteries"   -thread -linkpkg *_t.cmx AddUtilisateur_in_j.cmx AddUtilisateur_out_j.cmx  TypesMandarine_j.cmx ArborescenceCowebo_j.cmx Cowebo_Config_j.cmx CreateFolder_j.cmx CreateUser_j.cmx CreationDossier_j.cmx CreerGroupeRacine_j.cmx DeleteFolder_j.cmx FileProperties_j.cmx Flexigrid_j.cmx GetFileAndFolder_j.cmx GetFolder_j.cmx GetGroupTree_j.cmx GroupInfo_j.cmx LsGroup_j.cmx TypesClementine_j.cmx MetaDataUserCwb_j.cmx MetaData_cwb_j.cmx MetadataCat_j.cmx MetadataEdit_j.cmx PortefeuilleElectronique_j.cmx ProprietesFichier_j.cmx  Upload_j.cmx UserInfo_j.cmx UserLs_j.cmx  FullContact_j.cmx Cowebo_Config.cmx Utils.cmx Memcache.cmx Cowebo_Erreurs.cmx BDD.cmx ProfilUtilisateur.cmx Classif_Tags.cmx AlfrescoTalking.cmx  Cercle.cmx CleRSA_j.cmx  Certificat.cmx  Cowebo_CoffreFort.cmx Cowebo_securite.cmx Cowebo_Email.cmx Template_Email_Cowebo.cmx Contrat.cmx Messages.cmx Cowebo_Communaute.cmx Arborescence.cmx SMS.cmx Cowebo_Signature.cmx  Cowebo_CGI.cmx  Cowebo_MAIN.cmx
	
type: 
	cp DefinitionTypes/*.atd .
	make type1 type1bis type2 type3
	rm *.atd




ticker : atds types
	ocamlfind ocamlopt -c  -g  -package "react" tickerManager.ml
	ocamlfind ocamlopt -g  -o clock -package "react,unix" -linkpkg tickerManager.cmx

# Ligne de commande standard pour la compilation
# killall clementine ; killall sign ; rm sign ; make clean ; make atds types ; make sign ; echo "flush_all" | nc  127.0.0.1 11211 ; cp sign serveur/clementine ; cd serveur/ ; ./clementine&
	



#s/\(.*\)/\tatdgen -t \1.atd\r\tatdgen -j -std-json \1.atd\r\tocamlfind ocamlc -c -g \1_t.mli  -package atdgen\r\tocamlfind ocamlc -c -g \1_j.mli  -package atdgen\r\tocamlfind ocamlc -c -g \1_t.ml  -package atdgen\r\tocamlfind ocamlc -c -g \1_j.ml -package atdgen\r/g





clean:
	rm *.cm* ; rm *_t.ml* ; rm *_j.ml* ; rm *.o

top: all 
	#ocamlfind ocamlc -c -verbose -g   -package "netstring,netclient,atdgen,rpc-ssl,extlib"  Utils.cmo *_j.cmo Memcache.cmo MetaDataUserCwb_t.cmo MetaDataUserCwb_j.cmo Cowebo_Config.cmo AlfrescoTalking.ml
	#ocamlfind ocamlc -c -verbose -g   -package "netstring,postgresql,cryptokit,extlib" -thread  Cowebo_Communaute.ml
	utop  -init top.ml


arbo : all
	ocamlfind ocamlc -c -verbose -g   -package "netstring,netclient,atdgen,rpc-ssl,extlib"  Utils.cmo *_j.cmo Memcache.cmo MetaDataUserCwb_t.cmo MetaDataUserCwb_j.cmo Cowebo_Config.cmo AlfrescoTalking.ml
	ocamlfind ocamlc -c -verbose -g   -package "postgresql,cryptokit,extlib" -thread  Cowebo_Communaute.ml
	utop  -init prepaArboFromPlat.ml


secutop:
	top  -I /opt/local/lib/ocaml/site-lib/netsys -I /opt/local/lib/ocaml/site-lib/pcre -I /opt/local/lib/ocaml/site-lib/netstring  pcre.cma netsys_oothr.cma netsys.cma netng.cma   Utils.cmo -init Cowebo_securite.ml

coffretop: type
	ocamlfind ocamlc -c -verbose -g  -package "netstring,cryptokit,extlib" Cowebo_Config_t.cmo Cowebo_Config_j.cmo  Utils.ml
	ocamlfind ocamlc -c -verbose -thread Utils.cmo  Memcache.ml
	ocamlfind ocamlc -c -verbose -g -package "netstring,cryptokit,extlib" Utils.ml
	ocamlfind ocamlc -c -verbose -g -package "postgresql,cryptokit,extlib" -thread  BDD.ml
	utop  -I /opt/local/lib/ocaml/site-lib/postgresql -I /opt/local/lib/ocaml/site-lib/netsys -I /opt/local/lib/ocaml/site-lib/pcre -I /opt/local/lib/ocaml/site-lib/netstring postgresql.cma pcre.cma netsys_oothr.cma netsys.cma netstring.cma -I /opt/local/lib/ocaml/site-lib/extlib/   /opt/local/lib/ocaml/str.cma /opt/local/lib/ocaml/site-lib/easy-format/easy_format.cmo /opt/local/lib/ocaml/site-lib/cryptokit/cryptokit.cma /opt/local/lib/ocaml/site-lib/atd/atd.cma /opt/local/lib/ocaml/site-lib/biniou/biniou.cma /opt/local/lib/ocaml/site-lib/yojson/yojson.cmo /opt/local/lib/ocaml/site-lib/atdgen/atdgen.cma Cowebo_Config_j.cmo   extLib.cma  Memcache.cmo  Utils.cmo  BDD.cmo -init Cowebo_CoffreFort.ml

commutop:
	ocamlfind ocamlc -c -verbose -g -package "netstring" Utils.ml ;ocamlfind ocamlc -c -verbose -g -package "postgresql,cryptokit" -thread  BDD.ml ; utop  -I /opt/local/lib/ocaml/site-lib/postgresql -I /opt/local/lib/ocaml/site-lib/netsys -I /opt/local/lib/ocaml/site-lib/pcre -I /opt/local/lib/ocaml/site-lib/netstring  /opt/local/lib/ocaml/site-lib/extlib/extLib.cma postgresql.cma pcre.cma netsys_oothr.cma netsys.cma netstring.cma   Utils.cmo BDD.cmo -init Cowebo_securite.ml                                           

debug: all
	ocamlfind ocamlc  -g -verbose -o netplexDbg -package "netstring,netcgi2,unix,nethttpd-for-netcgi2,netplex,netclient,atdgen,ssl,rpc-ssl" GetFileAndFolder_t.cmo GetFileAndFolder_j.cmo -thread testNethttpd.ml -linkpkg 
	sudo ocamldebug netplexDbg
