#!/bin/sh
perl /Library/WebServer/CGI-Executables/blosxom.cgi  -password="doitdoit" -autotrack=yes ${*}

#supprimer les archives de jour
find -d /Users/barijaon/Sites -path "/Users/barijaon/Sites/[0-9][0-9][0-9][0-9]/[0-9][0-9]/[0-9][0-9]" -exec rm -rf {} \;


# supprimer les fichiers index.rss10short des archives chrono
find ~/Sites -path "*[0-9][0-9][0-9][0-9]/index.rss10short" -exec rm {} \;
find ~/Sites -path "*[0-9][0-9][0-9][0-9]/[0-9][0-9]/index.rss10short" -exec rm {} \;

# renommer le fichier index.rss10short en shortened.xml
mv ~/Sites/index.rss10short ~/Sites/shortened.xml

# renommer les autres fichiers index.rss10short en rss.xml
find ~/Sites -name index.rss10short -execdir mv index.rss10short rss.xml \;

# supprimer les autres fichiers .rss10short
find ~/Sites -name "*.rss10short" -exec rm {} \;

# renommer le fichier index.rss10 en rss.xml
mv ~/Sites/index.rss10 ~/Sites/rss.xml

# supprimer les autres fichiers .rss10
find ~/Sites -name "*.rss10" -exec rm {} \;

# renommer le fichier index.atom en atom.xml
mv ~/Sites/index.atom ~/Sites/atom.xml

# supprimer les autres fichiers .atom
find ~/Sites -name "*.atom" -exec rm {} \;


# rechercher le dernier post, et le marquer
# pour qu'il soit regenere lorsqu'un article plus recent sera cree
index=`sort -t'>' -k 2 -rn /Users/barijaon/blosxom/plugins/state/.entries_cache.index | head -n 1 | sed -e 's/=>.*//' | sed -e 's/\/blosxom\/posts/\/Sites/' | sed -e 's/\/[^\/]*$/\/index.html/' `
antepelt=`sort -t'>' -k 2 -rn /Users/barijaon/blosxom/plugins/state/.entries_cache.index | head -n 2 | tail -n 1 | sed -e 's/=>.*//' `

touch -r $antepelt $index


