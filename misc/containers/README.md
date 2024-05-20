# Dockerfiles for apps

## R Studio

### Build

```bash
docker build -t rstudio \
    --file rstudio.Dockerfile \
    .
```

### Run

Enter to the container
```bash
docker run -ti --rm -u $(id -u ${USER}) \
    -v $(pwd):/home/rstudio/host \
    rstudio \
    /bin/bash
```

Run R Studio Server

```bash
docker run --rm \
    --publish 8787:8787 \
    -v $(pwd):/home/rstudio/host \
    -v $(readlink -f ${HOME}/.config/rstudio/config.json):/home/rstudio/.config/rstudio/config.json \
    -v $(readlink -f ${HOME}/.config/rstudio/crash-handler.conf):/home/rstudio/.config/rstudio/crash-handler.conf \
    -v $(readlink -f ${HOME}/.config/rstudio/rstudio-prefs.json):/home/rstudio/.config/rstudio/rstudio-prefs.json \
    -e PASSWORD=rstudio \
    rstudio
```
