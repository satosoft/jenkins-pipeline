#!/usr/bin/env sh
echo "Removing api container if it exists..."
docker container rm -f api || true
echo "Removing network test-net if it exists..."
docker network rm test-net || true
echo "Deploying app ($registry:$BUILD_NUMBER)..."
docker network create test-net
docker container run -p 3000:3000 -d \
--name api \
--net test-net \
satosoft/alpine-node-docker:01
# Logic to wait for the api component to be ready on port 3000
read -d '' wait_for << EOF
echo "Waiting for API to listen on port 3000..."
while ! nc -z api 3000; do
sleep 0.1 
# wait for 1/10 of the second before check again
printf "."
done
echo "API ready on port 3000!"
EOF

docker container run --rm \
--net test-net \
node:12.10-alpine sh -c "$wait_for"
echo "Smoke tests..."

