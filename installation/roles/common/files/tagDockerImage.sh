#! /bin/bash
# Tag the docker image and publish in registry

#parameter : image - the image to tag
image=$1
#parameter : registry - the registry to publish in
registry=$2

# Tag the docker image
docker tag $image $registry/$image

# Log to the registry
# Todo : manage the credentials
docker login -u testuser -p testpassword -e user@polymont.fr $registry

# Push the image
docker push $registry/$image
