#!/bin/sh
set -x

/app/scripts/wait-for-it.sh $POSTGRES_HOST:5432 -- echo "db is up"
npx prisma $POSTGRES_HOST push
yarn start
