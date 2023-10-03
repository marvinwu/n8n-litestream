# N8n-litestream

the purpose of this repo is to setup an production grade n8n server with sqlite and litestream back up the database to s3, to achieve the following:

- 99.99% reliability
- cents on hosting

## How to run it locally

- build the image locally

```
docker build -t n8n-private .
```

- run it locally

```
docker run \
-it \
--rm \
--name n8n \
-p 5678:5678 \
-e ENABLE_LITESTREAM=false \
-v ~/.n8n:/home/node/.n8n n8n-private
```

## How to restore from backup

```
export REPLICA_URL=s3://yourbucket/yourbucket.sqlite
export S3_ACCESS_ID=
export S3_SECRET_KEY=
export S3_REGION=
```

then:

```
 litestream restore -o ~/.n8n/database.sqlite s3://yourbucket/yourbucket.sqlite
```

- run it locally

```
docker run \
-it \
--rm \
--name n8n \
-p 5678:5678 \
-e ENABLE_LITESTREAM=false \
-v ~/.n8n:/home/node/.n8n n8n-private
```

## run it locally with backup db retrieved from s3

- remove the db in ~/.n8n/

```
cd ~/.n8n
➜  .n8n rm -rf database.sqlite
➜  .n8n rm -rf database.sqlite-shm
➜  .n8n rm -rf database.sqlite-wal
```

- run the docker

```
docker run \
-it \
--rm \
--name n8n \
-p 5678:5678 \
-e ENABLE_LITESTREAM=false \
-e REPLICA_URL=s3://yourbucket/yourbucket.sqlite \
-e S3_ACCESS_ID=access_id \
-e S3_SECRET_KEY=secret_key \
-e S3_REGION=region \
-v ~/.n8n:/home/node/.n8n n8n-private

```

## FAQ

- how to upgrade

change Dockerfile line

```

FROM n8nio/n8n:1.1.1

```
