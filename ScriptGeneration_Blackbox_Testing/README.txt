*******************README

Auteur : Jean-Luc Amitousa Mankoy
E-mail : jean-luc.amitousa-mankoy@hotmail.fr

*******************

-Le but de chaque scripts dans ce r�pertoire est de tester la coh�rence de la base Tauto_IBDR avec
la dictionnaire de donn�es Dico_Tauto (version 2). Pour ce faire, chaque test sera r�alis� uniquement
� partir de ce dictionnaire (test en boite noire).

-Cette base aura pr�alablement �t� peupl� avec les scripts de peuplements suivant :
../ScriptGeneration.sql (version 1.0)
../ScriptPeuplementAlexis.sql (version 1.0)
../ScriptPeuplementBoris.sql (version 1.0)
../ScriptPeuplementJeanLuc.sql (version 1.0)

-Veiller � lancer ScriptSuppression puis ScriptGeneration avant chaque test.

-Certain tests ont pour but de faire rep�rer des erreurs au SGBD. Ce dernier est donc suceptible de s'arr�ter. Avant de commenter les tests concern�s, veuillez demander au responsable du script si l'erreur est signe de succ�s ou au contraite si elle met en �vidence une incoh�rence.
