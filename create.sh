#!/usr/bin/env bash

function usage {
    echo "usage: template_name project_name git_hub_account_name git_hub_token"
    exit 1
}

function replace_in_file {		
	REPLACE=$(echo "$2" | sed 's/\//\\\//g')
	sed "s/$1/$REPLACE/g" $3 > temp
	rm $3
	mv temp $3
}

template_name=$1
project_name=$2
git_hub_account_name=$3
git_hub_token=$4

if [ -z "$project_name" ] || [ -z "$template_name" ] || [ -z "$git_hub_account_name" ] || [ -z "$git_hub_token" ]  
  then
    usage
    exit 1
fi

. templates/$template_name.properties

cp -R templates/$template_name ../$project_name
cd ../$project_name

aws_region=$(aws configure get region)
echo "AWS Region is $aws_region"

aws_account_id=$(aws ec2 describe-security-groups --group-names 'Default' --query 'SecurityGroups[0].OwnerId' --output text)
echo "AWS Account ID is $aws_account_id"

for file in "${FILES_WITH_TOKENS_TO_REPLACE[@]}"
do
   :   
   echo "Replacing tokens in $file"
   replace_in_file PROJECT_NAME $project_name $file   
   replace_in_file AWS_REGION $aws_region $file
   replace_in_file AWS_ACCOUNT_ID $aws_account_id $file      
done

curl -u "$git_hub_account_name:$git_hub_token" https://api.github.com/user/repos -d '{"name":"'"$project_name"'"}'
echo "Initialising git"
git init
git add .
git commit -a -m "Initial commit"
git_repo=git@github.com:$git_hub_account_name/$project_name.git
echo "Pushing to $git_repo"
git remote add origin $git_repo
git push -u origin master

echo "Creating CloudFormation stack"
aws cloudformation create-stack --stack-name ${project_name} --template-body file://infrastructure/main-stack.yml --parameters ParameterKey=GitHubOwner,ParameterValue=$git_hub_account_name ParameterKey=GitHubToken,ParameterValue=$git_hub_token --capabilities CAPABILITY_IAM
