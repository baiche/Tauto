*******************README

Auteur : Jean-Luc Amitousa Mankoy
E-mail : jean-luc.amitousa-mankoy@hotmail.fr

*******************

-Le but de chaque scripts dans ce répertoire est de tester la cohérence de la base Tauto_IBDR avec
la dictionnaire de données Dico_Tauto (version 2). Pour ce faire, chaque test sera réalisé uniquement
à partir de ce dictionnaire (test en boite noire).

-Cette base aura préalablement été peuplé avec les scripts de peuplements suivant :
../ScriptGeneration.sql (version 1.0)
../ScriptPeuplementAlexis.sql (version 1.0)
../ScriptPeuplementBoris.sql (version 1.0)
../ScriptPeuplementJeanLuc.sql (version 1.0)

-Veiller à lancer ScriptSuppression puis ScriptGeneration avant chaque test.

-Certain tests ont pour but de faire repérer des erreurs au SGBD. Ce dernier est donc suceptible de s'arrêter. Avant de commenter les tests concernés, veuillez demander au responsable du script si l'erreur est signe de succès ou au contraite si elle met en évidence une incohérence.
