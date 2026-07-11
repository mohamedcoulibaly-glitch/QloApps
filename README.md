# QloApps - Guide rapide pour lancer le projet

Petit guide pour installer le projet en local sans se perdre.

## 1. Prérequis

Installe :

- XAMPP ou WAMP
- PHP compatible QloApps, idéalement PHP 8.1+
- MySQL ou MariaDB
- Un navigateur

Avec XAMPP, démarre :

- Apache
- MySQL

## 2. Récupérer le projet

Dans le dossier `htdocs` de XAMPP :

```bash
git clone https://github.com/mohamedcoulibaly-glitch/QloApps.git qloapps
```

Le projet doit ensuite être ici :

```text
C:\xampp\htdocs\qloapps
```

Sur Mac/Linux avec XAMPP, l'idée est la même : mettre le dossier dans le dossier web de XAMPP.

## 3. Créer la base de données

Ouvre phpMyAdmin :

```text
http://localhost/phpmyadmin
```

Crée une base de données, par exemple :

```text
qloapps
```

Si on t'a donné un fichier `.sql`, importe-le dans cette base depuis l'onglet **Importer** de phpMyAdmin.

Important : la base de données n'est pas versionnée dans Git. Si le site affiche une erreur de connexion ou une page vide, vérifie d'abord que la base existe et qu'elle a bien été importée.

## 4. Configurer la connexion à la base

Le fichier local de config est :

```text
config/settings.inc.php
```

Il n'est pas envoyé sur GitHub car il contient les identifiants locaux.

Exemple de configuration locale classique avec XAMPP :

```php
define('_DB_SERVER_', 'localhost');
define('_DB_NAME_', 'qloapps');
define('_DB_USER_', 'root');
define('_DB_PASSWD_', '');
define('_DB_PREFIX_', 'htl_');
```

Si le fichier n'existe pas, lance l'installation de QloApps ou demande le fichier local à la personne qui a déjà configuré le projet.

## 5. Lancer le site

Frontend :

```text
http://localhost/qloapps
```

Back-office :

```text
http://localhost/qloapps/admin929l2qgk0
```

Les identifiants admin ne sont pas dans le repo. Demande-les séparément.

## 6. Permissions et dossiers utiles

Si certaines pages ne chargent pas, vérifie que ces dossiers sont accessibles en écriture :

- `cache/`
- `log/`
- `upload/`
- `download/`
- `img/`

En local avec XAMPP sur Windows, c'est rarement bloquant. Sur Linux/Mac, il faudra peut-être ajuster les permissions.

## 7. Problèmes fréquents

Si tu vois une erreur de base de données :

- vérifie le nom de la base dans `config/settings.inc.php`
- vérifie l'utilisateur MySQL
- vérifie que le fichier SQL a été importé

Si le CSS ou les images ne chargent pas :

- vérifie que le projet est bien dans `htdocs/qloapps`
- vide le cache du navigateur
- vide le dossier `cache/smarty/cache` si besoin

Si le back-office ne s'ouvre pas :

- utilise bien `/admin929l2qgk0`
- vérifie que Apache est démarré
- vérifie que l'URL commence par `http://localhost/qloapps`

## 8. À ne pas envoyer sur GitHub

Ne pas versionner :

- `config/settings.inc.php`
- les exports SQL contenant des données privées
- les logs
- les fichiers uploadés par les utilisateurs

Ces fichiers dépendent de chaque machine ou peuvent contenir des informations sensibles.
