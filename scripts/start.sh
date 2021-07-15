#!/bin/sh
set -x

/app/scripts/wait-for-it.sh $POSTGRES_HOST:5432 -- echo "db is up"
export DATABASE_URL="postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:5432/$POSTGRES_DB"
echo $DATABASE_URL
npx prisma db push
yarn start
