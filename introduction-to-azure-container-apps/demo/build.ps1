docker build --no-cache -t kamalrathnayake/aca-demo-app -f 'src\Dockerfile' .
# docker run -d -p 80:80 kamalrathnayake/aca-demo-app
docker push kamalrathnayake/aca-demo-app