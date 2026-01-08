# SQL Server Docker Setup

This repository provides a repeatable database environment setup for running
SQL Server locally using Docker. It is intended as a foundation that other labs,
tutorials, and learning materials can build on.

Use this repo when you want a real SQL Server instance for practicing advanced SQL topics such as:

- Stored procedures and functions
- Users, roles, and permissions
- Row-Level Security (RLS)
- Query performance and execution plans
- Indexing and tuning
  All without cloud costs or restricted online sandboxes.

---

## What you get

- SQL Server 2022 Developer Edition running locally in Docker (free for non-production use)
- Persistent storage (your DB stays even after restart)
- A restore mechanism to load the `.bak` you place in the `backup/` folder

This is the same SQL Server engine used in production environments, running locally for learning and experimentation.

## Prerequisites

### 1) Docker Desktop

Install Docker Desktop:

https://www.docker.com/products/docker-desktop/

Verify:

```bash
docker --version
docker compose version
```

## Steps to start the container

### 1) Download a database backup

Download the [AdventureWorks](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms) sample database (you can you any version that you want).

The backup folder can have only one backup file at a time, if there are multiple files then the first one will be used by the container

Place the backup file here:

```bash
backup/
```

example:

```bash
backup/AdventureWorks2019.bak
```

The container will automatically detect and restore the backup at startup.

> Note: Backup files are intentionally not committed to this repository due to size.

### 2) Set Up environment Variables

Rename the `.env.sample` file to `.env`

```bash
mv .env.sample .env
```

Edit the .env file to update the `SA_PASSWORD` to what you want your passoword to the database be

```env
SA_PASSWORD=YourStr0ngP@ssw0rd!
```

Password requirements:

- Minimum 8 characters
- Uppercase letter
- Lowercase letter
- Number
- Special character

The .env file should remain local and must not be committed to source control.

## Running SQL Server

From the project root, run:

```bash
docker compose up --build
```

This will:

- Build the Docker image
- Start SQL Server on port 1433
- Run startup initialization scripts
- Restore the database from the .bak file in the backup/ folder

SQL Server will be available at:

- Host: localhost
- Port: 1433
- User: sa
- Password: from .env

## Stopping and restarting

To stop the environment:

```bash
docker compose down
```

To start it again later:

```bash
docker compose up
```

Your database data is preserved using Docker volumes.
