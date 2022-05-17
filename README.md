# terraform_aws
Demo project for first major Terraform + AWS + Kubernetes ,  It's not perfect by any means as I haven't pushed AWS this hard ever, or used terraform and kubernetes in about 4 years which didn't seem like that long ago to me but I guess it was and much has changed.

This project is designed to have 3 subnets in a AWS VPC with a EKS cluster running on the subnets. The subnets should be open to the intenet but there is some config issues with the networking of the EIPS and NAT gateways but, ingeneral this is close to working right but it was a good first try considering the catch up I was doing for this.  What needs to be done is a ALB set up between the subnets and the gateway but there was a minor issue creating the log bucket which prevented the ALB from being set up properly.  I received the "name already in use" error from AWS wether making it via code or 
manually.   

Note also, there is ubuntu images created that can run on the subnets in my AWS however they are commented out in the main.tf but still there.  They were used for some testing and might still be useful in the future so they were left in the code.

Additionally , there is a blank nginx docker and deployment yaml that was intended to be run on the kube cluster which isnt set up yet but there untested files are in the repo. It was to be run as if 2 independant services but the yaml files don't reflect this as I was going to start with one for testing and add / modify after I got "something" running for the test.




To deploy this project as is:
1:install terraform and awscli on your computer
  a: configure awscli credintials with AWS keys for connecting to your AWS sandbox
2:download this repo
3: go into the repo and run "terraform init"
4: optional, run "terraform plan"
5: Deploy the VPC by running "terraform apply"

6: As I said the nginx was never deployed to the cluster as I just didnt have time to get that far and am still reading a bit on the best way to get that there
Some ideas I was thinking about was:
1: Using the AWS build pipeline to build and deploy to the cluster
2: Figuring out how to get terraform to run it on my machine if possible
3: Building the image locally and pushing it to the cluster using, "kubectl" or some other tool
    I still plan on smoothing this out but for now this is how it sits as I have to focus on my real work  :)
    

Addional points of comment:

As stated first, I havent gotten this deep into AWS, Terraform, and Kubernetes in a few years and never composed them all together at once.  It was fun, and I am going to improve upon this.    
1: First thing should have been to map out the subnets, eips, public / NAT gateways,  ALB, etc..  so I would have then been able to better know what I needed to make instead of just starting to code this.
2: The file structure is a mess, it should be seperated by security.tf, network.tf, vpc.tf and so on but as I got in to it I made some changes and broke it up but it is not great as it sits and the next round from scratch will be better layed out.
3: datasources/ variables should have been used for most of the values instead of being hardcoded.  


This was a nice attempt that was fun to work on and I spent a bit to much time on it but didn't want to stop.  It is by no means a prod ready system but the next one will be?
