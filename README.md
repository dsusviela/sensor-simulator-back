Para correr:

1. Crear la imagen de docker a partir del dockerfile. Se tiene que llamar `sensorsimulatorbackend`

2. Levantar el docker compose

3. Deberia estar corriendo en `localhost:7000`


Se necesitan las siguientes env vars


RAILS_ENV
DATABASE_NAME
DATABASE_USER
DATABASE_PASSWORD
DATABASE_PORT
DATABASE_HOST
SRID
ORION_API_KEY
CONTEXT_BROKER_URL
IOT_AGENT_SOUTH_URL
IOT_AGENT_NORTH_URL
