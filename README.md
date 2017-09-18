# Project Templates

Automatically create 

* elb-java-docker: A Dockerized Java application deployed to AWS Elastic Beanstalk via AWS CodePipeline.
* cf-stack: A Cloudformation stack updated by CodePipeline when changes are checked in.

## Prerequisites

* [Java](https://www.java.com/en/download/help/download_options.xml)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) with administrator privileges
* [Github.com account](https://github.com) with a personal token setup that full permissions on 'repo' and 'admin:repo_hook' and push permission to account repos from the command line. 
 	 

## Usage

Clone the repository. From the project root run

	./create.sh TEMPLATE_NAME PROJECT_NAME GIT_HUB_ACCOUNT_NAME GIT_HUB_TOKEN
 
 * TEMPLATE_NAME: Name of the template to create the project from \[elb-java-docker, cf-stack\]
 * PROJECT_NAME: Name of the project. It should only contain letters and numbers and hyphens, should be less than 25 characters and lowercased.
 * GIT_HUB_ACCOUNT_NAME: Account where the repo will be created.
 * GIT_HUB_TOKEN: A personal token on the above account with full permission on repo and admin:repo_hook
