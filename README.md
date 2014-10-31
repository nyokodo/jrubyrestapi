# Simple JRuby REST API

This is a simple REST API developed in JRuby as an example of my work.

## Setup Instructions

1. Install JRuby 1.7.16: http://jruby.org/getting-started
2. Install Bundler by running following:
```
    jruby -S gem install bundler
```
3. Run Bundler to install project dependencies:
```
    jruby -S bundle install
```
4. Create database:
```
    jruby -S rake db:setup
```


## Run Instructions

* To start the server run:
```
    jruby -S rackup
```

## REST Operations

### POST /events
Add an event

```
curl -X POST "http://localhost:8999/events" -H "Content-Type: application/json" -d '{"data":"NAME is now at LATITUDE/LONGITUDE"}'
```

On Success:
HTTP Status Code 200
```javascript
{
   "status": "ok",
   "message": "Event created."
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": list of errors
}
```

### GET /events
List all events

```
curl "http://localhost:8999/events"
```

On Success:
HTTP Status Code 200
```javascript
list of
{
   "id": id,
   "data": event_data
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": "No events exist."
}
```

### DELETE /events
Delete all events

```
curl -X DELETE "http://localhost:8999/events"
```

On Success:
HTTP Status Code 200
```javascript
{
   "status": "ok",
   "message": "All events deleted."
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": "No events exist."
}
```

### GET /events/id
Return event

```
curl "http://localhost:8999/events/2"
```

On Success:
HTTP Status Code 200
```javascript
{
   "id": id,
   "data": event_data
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": "No such event exists."
}
```

### PUT /events/id
Update event

```
curl -X PUT "http://localhost:8999/events/2" -H "Content-Type: application/json" -d '{"data":"NAME is now at LATITUDE/LONGITUDE"}'
```

On Success:
HTTP Status Code 200
```javascript
{
   "status": "ok",
   "message": "Event has been updated."
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": "No such event exists."
}
```

### DELETE /events/id
Update event

```
curl -X DELETE "http://localhost:8999/events/2"
```

On Success:
HTTP Status Code 200
```javascript
{
   "status": "ok",
   "message": "Event has been deleted."
}
```

On Failure:
HTTP Status Code 500
```javascript
{
   "status": "error",
   "message": "No such event exists."
}
```