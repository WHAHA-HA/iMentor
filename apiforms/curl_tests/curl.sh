curl -v -H 'Content-Type: application/json;charset=utf-8' -H 'Accept: application/json, text/plain, */*' -d @data https://dev.imentordev.org/cchklist/picks/1201
sleep 5
curl -v -H 'Content-Type: application/json;charset=utf-8' -H 'Accept: application/json, text/plain, */*' https://dev.imentordev.org/cchklist/picks/1201

