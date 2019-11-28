#FROM openjdk:11
FROM alpine:3.10

LABEL "com.github.actions.name"="Guite-Generator-Action"
LABEL "com.github.actions.description"="Regenerate Zikula modules from ModuleStudio models"
LABEL "com.github.actions.icon"="orange"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/Guite/generator-action"
LABEL "homepage"="https://github.com/actions"
LABEL "maintainer"="Axel Guckelsberger <info@guite.de>"

RUN apk update && apk upgrade && apk --no-cache add bash openjdk11-jre fontconfig ttf-dejavu

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
