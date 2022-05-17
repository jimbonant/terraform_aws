



# Creating EC2 instances in private subnets
#resource "aws_instance" "private_inst_1" {
 # ami           = "ami-0fa49cc9dc8d62c84"
 # instance_type = "t2.micro"
 # subnet_id = "${aws_subnet.dev-private-1.id}"
 # key_name = "mainkeys"
 # tags = {
 #   Name = "private_inst_1"
#  }
#}

#resource "aws_instance" "private_inst_2" {
 # ami           = "ami-0fa49cc9dc8d62c84"
 # instance_type = "t2.micro"
 # subnet_id = "${aws_subnet.dev-private-2.id}"
 # key_name = "mainkeys"
 # tags = {
  #  Name = "private_inst_2"
 # }
#}

#resource "aws_instance" "private_inst_3" {
#  ami           = "ami-0fa49cc9dc8d62c84"
#  instance_type = "t2.micro"
#  subnet_id = "${aws_subnet.dev-private-3.id}"
#  key_name = "mainkeys"
#  tags = {
#    Name = "private_inst_3"
 # }
#}


resource "aws_eks_cluster" "altana" {
  name     = "altana"
  role_arn = aws_iam_role.altana.arn

  vpc_config {
    subnet_ids = [aws_subnet.dev-private-1.id,aws_subnet.dev-private-2.id, aws_subnet.dev-private-2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.altana-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.altana-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.altana.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.altana.certificate_authority[0].data
}

resource "aws_iam_role" "altana" {
  name = "eks-cluster-altana"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "altana-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.altana.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "altana-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.altana.name
}



