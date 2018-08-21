# SSL Ready

Make your domain ready for HTTPS. Thanks to [Let’s Encrypt](https://letsencrypt.org/).

## Requirement
- SQLite
- Redis
- PostgreSQL (only for production)

## Setup
```bash
$ mv config/lc.yml.bak config/lc.yml
$ FRONT_SERVER_DOMAIN=test.com rails s
```