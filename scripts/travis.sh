#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Need test suite argument."
    exit -1
fi

if [ "$1" = "misc" ]; then
    npm run build
    mocha --exit --require ts-node/register/type-check --bail server/tests/client.ts server/tests/activitypub.ts
elif [ "$1" = "api" ]; then
    npm run build:server
    mocha --exit --require ts-node/register/type-check --bail server/tests/api/index.ts
elif [ "$1" = "cli" ]; then
    npm run build:server
    mocha --exit --require ts-node/register/type-check --bail server/tests/cli/index.ts
elif [ "$1" = "api-fast" ]; then
    npm run build:server
    mocha --exit --require ts-node/register/type-check --bail server/tests/api/index-fast.ts
elif [ "$1" = "api-slow" ]; then
    npm run build:server
    mocha --exit --require ts-node/register/type-check --bail server/tests/api/index-slow.ts
elif [ "$1" = "lint" ]; then
    cd client || exit -1
    npm run lint || exit -1

    cd .. || exit -1
    npm run tslint -- --project ./tsconfig.json -c ./tslint.json server.ts "server/**/*.ts" || exit -1
fi
