# Project Templates

Automatically create 

* elb-java-docker: A Dockerized Java application deployed to AWS Elastic Beanstalk via AWS CodePipeline.
* cf-stack: A CloudFormation stack updated by CodePipeline when changes are checked in.

## Prerequisites

* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) with administrator privileges
* [Github.com account](https://github.com) with a personal token setup that has full permissions on 'repo' and 'admin:repo_hook' and push permission to account repos from the command line.
* [curl](https://curl.haxx.se/)
 	 

## Usage

Clone the repository. From the project root run

	./create.sh [-t template_name] [-p project_name] [-a git_hub_account_name] [-o git_hub_org_name] [-m git_hub_team_id] [-k git_hub_token] [-f aws_profile]
 
 * template_name: Name of the template to create the project from. \[elb-java-docker, cf-stack\] (Required)
 * project_name: Name of the project. It should only contain letters and numbers and hyphens, should be less than 25 characters and lower-cased. (Required)
 * git_hub_account_name: Account where the repo will be created. (Required if git_hub_org_name not specified)
 * git_hub_org_name: Organisation account where the repo will be created. (Required if git_hub_account_name not specified)
 * git_hub_team_id: Id of GitHub team to give admin access on the repository.
 * git_hub_token: A personal with full permission on repo and admin:repo_hook. (Required)
 * aws_profile: Name of the aws profile to use when creating the project stack if the stack should not be created in the default account.
