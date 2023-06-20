# digdag-docker
Official Docker image for the digdag server

```sh
# run the digdag server container
$ docker compose up -d

# execute a command in a running container
$ docker exec -it digdag /bin/sh
```

Create digdag workflow
```sh
$ digdag init example
```

Show example/example.dig
```sh
$ cat example/example.dig
timezone: UTC

+setup:
  echo>: start ${session_time}

+disp_current_date:
  echo>: ${moment(session_time).utc().format('YYYY-MM-DD HH:mm:ss Z')}

+repeat:
  for_each>:
    order: [first, second, third]
    animal: [dog, cat]
  _do:
    echo>: ${order} ${animal}
  _parallel: true

+teardown:
  echo>: finish ${session_time}
```

Push example workflow to diadag
```sh
$ digdag push workflow --project example/ -e 0.0.0.0:9000

```