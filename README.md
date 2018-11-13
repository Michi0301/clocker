# README

Clocker enables restful clocking apis for the Sage HR portal.

The portal is accessed via screenscraping.

An audit trail is provided via the `ClockEvent` model.

## Configuration

Set the environment variable `SAGE_POTRAL_URL` to point to your Sage HR portal. 

## Api

All requests require: `Content-Type: application/json`

Either submit your credentials via the request payload:

```
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
```
{
  "success": true
}
```
### POST /api/sage/clockout

Response:

Success:

Status: `201`
```
{
  "success": true
}
```

### POST /api/sage/pause

Response:

Success:

Status: `201`
```
{
  "success": true
}
```

### POST /api/sage/current

Response:

Success:

Status: `201`
```
{
  "success": true,
  "current_state": "absent"
}
```


