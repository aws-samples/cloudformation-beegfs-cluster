## BeeGFS Parallel File System on AWS  

This repo contains a CloudFormation template to automate the deployment of a BeeGFS Parallel File System on AWS. 

The CloudFormation template will deploy BeeGFS parallel virtual file system. Internally it deploys 7 EC2 instances (One Management/Tier2 node, one Client node, two Tier1 nodes and three Tier2 nodes) inside a private subnet, and a single bastion host inside a public subnet. Admis can access the cluster client node by SSH to the bastion host. 


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

