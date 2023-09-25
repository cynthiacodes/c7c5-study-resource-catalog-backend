# Study Resource Catalog Backend

## Install Dependencies

`yarn`

## DB Setup

Copy .env.example to .env and set `DATABASE_URL`, `LOCAL_DATABASE_URL` and `PORT` to your liking.

e.g.

```
DATABASE_URL=postgres://someuser:somebigsecretpassword@somedbhost/pastebin
LOCAL_DATABASE_URL=postgres://neill@localhost/pastebin
PORT=4000
```

You will need to create your own databases for this project - certainly one remotely and ideally one locally, too, for development and testing.

Run the following SQL scripts to create the tables. Located in the following directory `sql`

```
1-createUsers.sql
2-createResources.sql
3-createOpinions.sql
4-createToStudy.sql
5-createComments.sql
```

Hosts for postgres with a free offering include:

-   https://render.com
-   https://www.elephantsql.com/
-   https://supabase.com/

## Running locally

`yarn start:dev`

The env var LOCAL_DATABASE_URL will be consulted.

## Running locally against a remote db

`yarn start:dev-with-remote-db`

The env var DATABASE_URL will be consulted.

# Deploying to render.com

To deploy to render.com:

-   build command should be `yarn && yarn build`

## Running on render.com

After deployment, render.com should be set up to run either `yarn start` or
`node dist/server.js`

The env var DATABASE_URL will be consulted and so must be set on render.com prior to application start.
