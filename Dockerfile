FROM alpine
# TODO look for better fitting images
# e.g. openjdk alpine
# see https://github.com/docker-library/docs/tree/master/openjdk

LABEL "com.github.actions.name"="Guite-Generator-Action"
LABEL "com.github.actions.description"="regenerate Zikula modules from ModuleStudio models"
LABEL "com.github.actions.icon"="orange"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/Guite/generator-action"
LABEL "homepage"="https://github.com/actions"
LABEL "maintainer"="Axel Guckelsberger <info@guite.de>"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
