## BeeGFS Parallel File System on AWS  

This repo contains a CloudFormation template to automate the deployment of a BeeGFS Parallel File System on AWS. 

The CloudFormation template will deploy BeeGFS parallel virtual file system. Internally it deploys 7 EC2 instances (One Management/Tier2 node, one Client node, two Tier1 nodes and three Tier2 nodes) inside a private subnet, and a single bastion host inside a public subnet. Admis can access the BeeGFS client node via SSH from the bastion host. 



## Deploying BeeGFS Cluster 
From the [AWS console](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/template) upload the [BeeGFSCluster.yaml](https://github.com/aws-samples/cloudformation-beegfs-cluster/raw/main/BeeGFSCluster.yaml) teamplate. Make sure you select the proper instance size  
![alt text](https://github.com/aws-samples/cloudformation-beegfs-cluster/blob/main/aws_console.png)


From the command line, run:

```bash
aws cloudformation deploy --template-file BeeGFSCluster.yaml --stack-name <STACK-NAME>  --parameter-overrides BastionhostType=m5n.large ClientInstanceType=m5n.2xlarge ManagementInstanceType=d3en.2xlarge SSHKeyName=<KEYNAME> T1InstanceType=i3en.12xlarge T2InstanceType=d3en.2xlarge --capabilities=CAPABILITY_NAMED_IAM
```

![alt text](https://github.com/aws-samples/cloudformation-beegfs-cluster/blob/main/architecture_diagram.png)

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

