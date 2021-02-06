# dspace-aws-testing

A work in progress, a collection of Terraform and Ansible configurations for standing up DSpace7 in AWS.

Here are our rough notes so far:

## Terraform stuff

You need an .aws/credentials file, and also the same information exported as ENV variables. You get the credentials from your AWS SSO login, click on AWS Account, CDL Sandbox, Command line or programatic access, and copy/paste credentials to ~/.aws/credentials AND to your bash config files (I have a ~/.creds.env file I source from ~/.bashrc with the following:

`if [[ -r "${HOME}/.creds.env" ]]; then
     source "${HOME}/.creds.env"
fi`

AWS CLI works with the .aws/credentials file, as do a few other tools, but Ansible and Terraform both seem to prefer the environment variables.

Be sure to not commit the `.creds.env` file to any GitHub repository, or hilarity will ensue.

To run the terraform plan file, in the dspace-aws-testing/terraform folder, run:

`terraform apply`

You can tear it all down with:

`terraform destroy`



## Ansible stuff

We are using the AWS EC2 inventory plugin for Ansible, which comes standard with Ansible, however, you need to install Ansible via Pip to get a new enough version, and install some modules so that the plugin can work correctly.

Docs on inventory plugins:
https://docs.ansible.com/ansible/latest/plugins/inventory.html

To see what inventory plugins are installed:
`ansible-doc -t inventory -l`

To read up on the amazon.aws.aws_ec2 plugin:
`ansible-doc -t inventory amazon.aws.aws_ec2`

### Installing Ansible and related modules:

`pip install ansible boto boto3 botocore`

To confirm things are working, run this command from the dspace-aws-testing/ansible folder:

`ansible-inventory -i pub-ds-aws_ec2.yml --graph`

output will look like this, if you've run the terraform plan file:

`@all:
  |--@arch_x86_64:
  |  |--pub-ds-api
  |  |--pub-ds-client
  |--@aws_ec2:
  |  |--pub-ds-api
  |  |--pub-ds-client
  |--@instance_type_t3_medium:
  |  |--pub-ds-api
  |--@instance_type_t3_micro:
  |  |--pub-ds-client
  |--@project_dspace:
  |  |--pub-ds-api
  |  |--pub-ds-client
  |--@ungrouped:
 `
