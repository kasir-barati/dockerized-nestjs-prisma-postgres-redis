# NestJS, Prisma, Redis, Postgres

Dockerize NestJS, Prisma project which needs redis and postgresql

## Why .npmrc?

Because most of times I got this error:

- Just note that I am not 100% sure which `.npmrc` will resolve your problem.
- I am still wondered and disappointed due to this bad and slow installation time. I did a `time docker build -t dev.Dockerfile . -t temp:1` and the result was awful on my system. It takes 2 minute - `real 2m9.015s` - to build a simple base image without any code, test, and too many 3rd party packages. Based on what I know feedback cycle should be very short and fast to help developer build and develop very fast. To be agile you need agile tool too.
- Note that the `.npmrc` goal is not to take advantage of cache.

```cmd
Step 1/16 : FROM node:16.14.0-alpine3.15 as build_stage
 ---> 0e1547c0f4a4
Step 2/16 : WORKDIR /app
 ---> Using cache
 ---> 6a7d134451ce
Step 3/16 : COPY . .
 ---> 5c7e7170d063
Step 4/16 : RUN NODE_ENV=development npm i
 ---> Running in 341cca48b7e6
npm notice
npm notice New minor version of npm available! 8.3.1 -> 8.5.3
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v8.5.3>
npm notice Run `npm install -g npm@8.5.3` to update!
npm notice
npm ERR! code ERR_SOCKET_TIMEOUT
npm ERR! network Socket timeout
npm ERR! network This is a problem related to network connectivity.
npm ERR! network In most cases you are behind a proxy or have bad network settings.
npm ERR! network
npm ERR! network If you are behind a proxy, please make sure that the
npm ERR! network 'proxy' config is set properly.  See: 'npm help config'

npm ERR! A complete log of this run can be found in:
npm ERR!     /root/.npm/_logs/2022-03-07T17_56_36_495Z-debug-0.log
```
