#docker build -t somatic/bat-country .
docker run --env-file=/home/ubuntu/.env -d -p 5000:5000 somatic/bat-country python /home/ubuntu/somaticagent/web.py -s
sleep 1
curl --fail -X POST -F i=@tests/slawek.jpg -F o=blah.jpg  http://127.0.0.1:5000/run
