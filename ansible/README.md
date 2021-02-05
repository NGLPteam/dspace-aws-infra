

# Notes

Here's how to get the public IP address of the pub-ds-api server

`ansible-inventory -i pub-ds-aws_ec2.yml --list | jq '._meta.hostvars[] | select(.tags["Name"] == "pub-ds-api") | .public_ip_address'`
