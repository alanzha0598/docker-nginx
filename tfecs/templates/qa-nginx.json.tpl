[
  {
    "name": "qa-nginx",
    "image": "${REPOSITORY_URL}:${APP_VERSION}",
    "essential": true,
    "memory": 256,
    "cpu": 256,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
		    "protocol": "tcp"
      }
    ]
  }
]
