*******************README

Auteur : Jean-Luc Amitousa Mankoy
E-mail : jean-luc.amitousa-mankoy@hotmail.fr

*******************

-Pour ajouter proprement ces fichiers � votre projet Visual Studio 2012 proc�d� ainsi:
	-Click droit sur votre solution.
	-Ajouter un �l�ment existant.
	-Dans le browser qui s'affiche, selectionner tout les
	 fichiers c sharp de ce r�pertoire.
	-Avant de valider l'ajout, vous devez modifier l'option
	 dans la liste d�roulante en bas du formulaire. 
	 Elle contient par d�faut la valeur "Ajouter" mais valeur 
	 qu'il faut est "Ajouter en tant que lien". Ainsi vos
	 fichier seront mis � jour automatiquement aussi bien 
	 dans votre d�p�t que dans votre projet Visual Studio 2012.

-Le but de chaque fichier dans ce r�pertoire est de tester la coh�rence de la base Tauto_IBDR avec le dictionnaire de donn�es Dico_Tauto (version 2). Pour ce faire, chaque test sera r�alis� uniquement � partir de ce dictionnaire (test en boite noire).

-Cette base aura pr�alablement �t� nettoy� et peupl� avec les scripts de peuplements suivant (� executer dans l'ordre):

../ScriptSuppression.sql (version 1.0)
../ScriptGeneration.sql (version 1.0)
../ScriptPeuplementAlexis.sql (version 1.0)
../ScriptPeuplementBoris.sql (version 1.0)
../ScriptPeuplementJeanLuc.sql (version 1.0)
