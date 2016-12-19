# amazonetes


This repository provides an opinionated Terraform module to deploy a Kubernetes cluster on AWS using CoreOS.

It is a **WORK IN PROGRESS**, please use it on your own risk.

# Index

* [amazonetes](#amazonetes)
* [Index](#index)
* [Quick Start](#quick-start)
* [Bastion](#bastion)

# Quick Start

It creates an etcd cluster and private docker registry with S3 storage backend, sets up a private Route53 DNS and then creates Kubernetes master and worker nodes. All internal traffic is encrypted using self signed certificates.

First, init terraform modules.

```sh
terraform get
```

Second , choose a public key of your ssh key. It will get uploaded to all instances so you can ssh via the bastion.

```sh
export TF_VAR_public_key='ssh-rsa...'
```

Next, use `terraform plan` command to preview infrastructure that will get created:

```sh
make plan DEPLOY_ENV=stage
```

Finally, if you are happy with planned changes, use `terraform apply` to deploy Kubernetes:

```sh
make apply DEPLOY_ENV=stage
```

You can delete the Kubernetes cluster using `terraform destroy` command:

```sh
make destroy DEPLOY_ENV=stage
```

# Bastion

Once you run the `apply` command, Terraform will write `nat_public_ip` output to the console at the end of deployment.

In order to ssh to instances inside the VPC, run this script to create a local `ssh.config` file:

```sh
./scripts/render-ssh-config $NAT_PUBLIC_IP
```

Replace `$NAT_PUBLIC_IP` with the real value from Terraform outputs.

Then you will be able to ssh to instances like this:

```sh
ssh -F ssh.config 10.0.1.10
```
