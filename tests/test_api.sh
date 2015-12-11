#docker build -t somatic/bat-country .
docker run  -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"  -d -p 5000:5000 somatic/bat-country python /home/ubuntu/somaticagent/web.py -s
sleep 1
curl --fail -X POST -F i=@tests/slawek.jpg -F o=blah.jpg  http://127.0.0.1:5000/run
sleep 1
docker run  -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"  -t -p 5000:5000 somatic/bat-country python /home/ubuntu/somaticagent/apitester.py -n 1