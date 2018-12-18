# README

Clocker enables restful clocking apis for the Sage HR portal.

The portal is accessed via screenscraping.

An audit trail is provided via the `ClockEvent` model.

## Configuration

Set the environment variable `SAGE_POTRAL_URL` to point to your Sage HR portal.

### Deployment to Heroku

You can deploy this application to Heroku with just a click on the following button:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https%3A%2F%2Fgithub.com%2FMichi0301%2Fclocker)

## Api

All requests require: `Content-Type: application/json`

Either submit your credentials via the request payload:

```json
{
  "username": "HomerS",
  "password": "Doughnut"
}
```

**or use HTTP Basic Auth (in this case, no payload is required).**

Supported actions:

### POST /api/sage/clockin

Response:

Success:

Status: `201`
```json
{
  "success": true
}
```
### POST /api/sage/clockout

Response:

Success:

Status: `201`
```json
{
  "success": true
}
```

### POST /api/sage/pause

Response:

Success:

Status: `201`
```json
{
  "success": true
}
```

### POST /api/sage/current

Response:

Success:

Status: `201`
```json
{
  "success": true,
  "current_state": "absent"
}
```
