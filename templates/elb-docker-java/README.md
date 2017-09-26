# PROJECT_NAME

## Prerequisites

* [Java](https://www.java.com/en/download/help/download_options.xml)
* [Docker](https://www.docker.com/products/docker)

# Continuous Delivery Pipeline
* [CodePipeline](https://AWS_REGION.console.aws.amazon.com/codepipeline/home?region=AWS_REGION#/view/PROJECT_NAME)
* [Build Job](https://AWS_REGION.console.aws.amazon.com/codebuild/home?region=AWS_REGION#/projects/PROJECT_NAME-build/view)
* [Acceptance Test Job (Staging)](https://AWS_REGION.console.aws.amazon.com/codebuild/home?region=AWS_REGION#/projects/PROJECT_NAME-acceptance-test-staging/view)
* [Acceptance Test Job (Production)](https://AWS_REGION.console.aws.amazon.com/codebuild/home?region=AWS_REGION#/projects/PROJECT_NAME-acceptance-test-production/view)
* [Docker Images](https://AWS_REGION.console.aws.amazon.com/ecs/home?region=AWS_REGION#/repositories/PROJECT_NAME)
* [Elastic Beanstalk](https://AWS_REGION.console.aws.amazon.com/elasticbeanstalk/home?region=AWS_REGION#/applications?applicationNameFilter=PROJECT_NAME)
