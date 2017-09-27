#!/usr/bin/env bash

function usage {
    echo "usage: [-t template_name] [-p project_name] [-a git_hub_account_name] [-o git_hub_org_name] [-m git_hub_team_id] [-k git_hub_token] [-f aws_profile]"
    exit 1
}

function replace_in_file {		
	REPLACE=$(echo "$2" | sed 's/\//\\\//g')
	sed "s/$1/$REPLACE/g" $3 > temp
	rm $3
	mv temp $3
}

private_repo=false

while getopts ":t:p:a:o:m:k:f:v" opt; do
  case $opt in
    t)
      template_name=$OPTARG
      ;;
    p)
      project_name=$OPTARG
      ;;
    a)
      git_hub_account_name=$OPTARG
      ;;
    o)
      git_hub_org_name=$OPTARG
      ;;    
    m)
      git_hub_team_id=$OPTARG
      ;;
    k)
      git_hub_token=$OPTARG
      ;;
    f)
      aws_profile_name=$OPTARG
      ;;
    v)
      private_repo=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage      
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$template_name" ] || [ -z "$project_name" ] || [ -z "$git_hub_token" ]  
  then
    usage
    exit 1
fi

. templates/$template_name.properties

cp -R templates/$template_name ../$project_name
cd ../$project_name

aws_region=$(aws configure get region)
echo "AWS Region is $aws_region"

if [ "$aws_profile_name" ]
  then
	aws_account_id=$(aws ec2 describe-security-groups --region ${aws_region} --group-names 'Default' --query 'SecurityGroups[0].OwnerId' --output text --profile $aws_profile_name)  
else
	aws_account_id=$(aws ec2 describe-security-groups --region ${aws_region} --group-names 'Default' --query 'SecurityGroups[0].OwnerId' --output text)
fi

echo "AWS Account ID is $aws_account_id"

for file in "${FILES_WITH_TOKENS_TO_REPLACE[@]}"
do
   :   
   echo "Replacing tokens in $file"
   replace_in_file PROJECT_NAME $project_name $file   
   replace_in_file AWS_REGION $aws_region $file
   replace_in_file AWS_ACCOUNT_ID $aws_account_id $file      
done

if [ "$git_hub_account_name" ]
  then
	curl -X POST -u "$git_hub_account_name:$git_hub_token" https://api.github.com/user/repos -d '{"name":"'"$project_name"'", "private":'$private_repo'}'  
else
	curl -X POST -u ":$git_hub_token" https://api.github.com/orgs/$git_hub_org_name/repos -d '{"name":"'"$project_name"'", "private":'$private_repo'}'
	if [ "$git_hub_team_id" ]
	  then
		curl -X PUT -u ":$git_hub_token" https://api.github.com/teams/$git_hub_team_id/repos/$git_hub_org_name/$project_name -d '{"permission":"admin"}'  	
	fi
fi

echo "Initialising git"
git init
git add .
git commit -a -m "Initial commit"

if [ "$git_hub_account_name" ]
  then
	git_repo=git@github.com:$git_hub_account_name/$project_name.git  
else
	git_repo=git@github.com:$git_hub_org_name/$project_name.git	
fi

echo "Pushing to $git_repo"
git remote add origin $git_repo
git push -u origin master

if [ "$git_hub_account_name" ]
  then
	git_owner=$git_hub_account_name  
else
	git_owner=$git_hub_org_name	
fi

echo "Creating CloudFormation stack"
if [ "$aws_profile_name" ]
  then
	aws cloudformation create-stack --stack-name ${project_name} --template-body file://infrastructure/main-stack.yml --region ${aws_region} --parameters ParameterKey=GitHubOwner,ParameterValue=$git_owner ParameterKey=GitHubToken,ParameterValue=$git_hub_token --capabilities CAPABILITY_IAM  --profile $aws_profile_name  
else
	aws cloudformation create-stack --stack-name ${project_name} --template-body file://infrastructure/main-stack.yml --region ${aws_region} --parameters ParameterKey=GitHubOwner,ParameterValue=$git_owner ParameterKey=GitHubToken,ParameterValue=$git_hub_token --capabilities CAPABILITY_IAM	
fi
