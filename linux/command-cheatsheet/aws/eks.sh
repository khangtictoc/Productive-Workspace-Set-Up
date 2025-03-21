curl -O https://raw.githubusercontent.com/awslabs/amazon-eks-ami/master/templates/al2/runtime/max-pods-calculator.sh
chmod +x max-pods-calculator.sh
./max-pods-calculator.sh --instance-type c6g.8xlarge --cni-version 1.9.0-eksbuild.1