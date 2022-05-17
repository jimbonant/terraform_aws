# terraform_aws
Demo project for first major Terraform + AWS + Kubernetes ,  It's not perfect by any means as I haven't pushed AWS this hard ever, or used terraform and kubernetes in about 4 years.

This project is designed to have 3 subnets in a AWS VPC with a EKS cluster running on the subnets. The subnets should be open to the intenet but there is some config issues with the networking of the EIPS and NAT gateways but
ingeneral this is close to working right but it was a good first try considering the catch up I was doing for this.  What needs to be done is a ALB set up between the subnets and the gateway but there
was a minor issue creating the log bucket which prevented the ALB from being set up properly.  I received the "name already in use" error from AWS wether making it via code or 
manually.   

Additionally , there is a blank nginx docker and deployment yaml that was intended to be run on the kube cluster which isnt set up yet but there untested files are in the repo.



To deploy this project as is:
1:install terraform and awscli on your computer
  a: configure awscli credintials with AWS keys for connecting to your AWS sandbox
2:download this repo
3: go into the repo and run "terraform init"
4: optional, run "terraform plan"
5: Deploy the VPC by running "terraform apply"
