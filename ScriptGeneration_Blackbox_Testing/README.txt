*******************README

Auteur : Jean-Luc Amitousa Mankoy
E-mail : jean-luc.amitousa-mankoy@hotmail.fr

*******************

-Pour ajouter proprement ces fichiers à votre projet Visual Studio 2012 procédé ainsi:
	-Click droit sur votre solution.
	-Ajouter un élément existant.
	-Dans le browser qui s'affiche, selectionner tout les
	 fichiers c sharp de ce répertoire.
	-Avant de valider l'ajout, vous devez modifier l'option
	 dans la liste déroulante en bas du formulaire. 
	 Elle contient par défaut la valeur "Ajouter" mais valeur 
	 qu'il faut est "Ajouter en tant que lien". Ainsi vos
	 fichier seront mis à jour automatiquement aussi bien 
	 dans votre dépôt que dans votre projet Visual Studio 2012.

-Le but de chaque fichier dans ce répertoire est de tester la cohérence de la base Tauto_IBDR avec le dictionnaire de données Dico_Tauto (version 2). Pour ce faire, chaque test sera réalisé uniquement à partir de ce dictionnaire (test en boite noire).

-Cette base aura préalablement été nettoyé et peuplé avec les scripts de peuplements suivant (à executer dans l'ordre):

../ScriptSuppression.sql (version 1.0)
../ScriptGeneration.sql (version 1.0)
../ScriptPeuplementAlexis.sql (version 1.0)
../ScriptPeuplementBoris.sql (version 1.0)
../ScriptPeuplementJeanLuc.sql (version 1.0)
