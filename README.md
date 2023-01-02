In order to deploy the frontend i need:

- Cloudfront id
- S3 bucket

In order to deploy the backend i need:

- ECR repository

todo:
automatically, on code push, update the ecs task def with the new pushed image and deploy it

- https://particule.io/en/blog/cicd-ecr-ecs/
- https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service

automatise initial account and bucket creation

get the cloudfrontid and ecr repository from params

