
# build

```shell
VERSION=0.13.0
docker build -t tercen/simple_docker_operator:$VERSION .
docker push tercen/simple_docker_operator:$VERSION
git add -A && git commit -m "$VERSION" && git tag -a $VERSION -m "++" && git push && git push --tags

```

# inspect

```shell
docker run --rm --entrypoint=bash tercen/simple_docker_oprator:0.0.0 -c "R --version"
docker run --rm --entrypoint=bash tercen/simple_docker_operator:$VERSION -c "R --version"
docker run -it --rm --entrypoint=bash tercen/simple_docker_operator:$VERSION
```


# push

```shell
docker push tercen/simple_docker_oprator:$VERSION
```