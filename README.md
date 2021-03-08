
# build

```shell
VERSION=0.0.0
docker build -t tercen/simple_docker_oprator:$VERSION .
docker push tercen/simple_docker_oprator:$VERSION
git add -A && git commit -m "$VERSION" && git tag -a $VERSION -m "++" && git push && git push --tags

```

# inspect

```shell
docker run --rm --entrypoint=bash tercen/simple_docker_oprator:$VERSION -c "R --version"
docker run -it --rm --entrypoint=bash tercen/simple_docker_oprator:$VERSION
```


# push

```shell
docker push tercen/simple_docker_oprator:$VERSION
```