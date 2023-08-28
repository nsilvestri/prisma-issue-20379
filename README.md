# Prisma Issue #20379

Prisma will silently `DROP CASCADE` without warning when running `prisma migrate reset`, causing objects in schemas not specified to Prisma to be dropped.

The `DATABASE_URL` environment variable specifies the schema to connect to as `app`. Prisma will correctly create all new tables there. However, there are materialized views dependent on those schemas which are in the `public` schema. Prisma is only configured to use the `app` schema, but will delete dependent objects in the `public` schema silently and without warning.

While not necessarily a bug, it is definitely a potential pitfall to users who are attempting to add Prisma to an existing project.

## Instructions

Requirements: Node, npm, and Docker. Versions shouldn't particularly matter, but it was tested on Node v20.5.1, npm v9.8.0, and Docker v24.0.2. Prisma version is specified in `package.json`

1. Run `npm install` to install dependencies
2. Run `docker compose up -d` to start a new Postgres database. It is configured to use the `DATABASE_URL` already specified in `.env`
3. Run `npx prisma migrate reset` to initialize the database schema
4. Run the script found in `seed-data-and-create-mv.sql` to add some example data to the newly created tables, and add a materialized view `user_posts` dependent on that data. Notably, the materialized view is in the `public` schema, not the `app` schema as specified in the `DATABASE_URL`
5. Run `npx prisma migrate reset`
6. Observe that the materialized view `user_posts` has been deleted
