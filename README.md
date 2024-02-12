# xalts-Assignment

To create REST API , I have used flask framework of python to simply create one route to handle GET request and return response.
Name of my python code is app.py.
Now , I have dockerize this code to test if this is working fine. 
After getting response by hitting curl localhost:5000/health, I know my container is working fine with proper port mapping.
Now , I have pushed my dockerimage to dockerhub so that I can use that image under my terraform file.

Using terraform I have provisioned one ec2 instance with proper security groups and then setup docker inside that ec2-instance using terraform only and run one container using that same image that I have pushed to docker-hub.
