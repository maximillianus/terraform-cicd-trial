# terraform-cicd-trial
This is trial CI/CD using Terraform.

We will be exploring ways to do this:

1. Using Github actions only without HCP terraform
   1. Add `.github/workflows/terraform.yaml` file
   2. That file contains github actions to setup terraform and run it
   3. *This action will be run on Github runner machine (linux/win/mac machine). Ensure to use standard machine and keep build time <2000mins to ensure within free tier.*
   4. Using this method, we cannot save terraform's state file in Github. Must use another backend, either s3, hcp terraform (remote), or others.
   5. Either long-term access keys (*aws_access_key* and *secret_access_key*) or short-term keys using Github's OIDC are needed

2. Using Github actions and HCP terraform
   1. This can be done in 2 ways: 
      1. Using HCP Terraform as state backend only - refer to `.github/inactive-workflows/hcp-terraform-backend-cicd.yaml`
      2. Using HCP Terraform to store state and runs the infrastructure creation, thus keeping Github only for version control - refer to `.github/inactive-workflows/hcp-terraform-cicd.yaml`
   2. Both ways require storing HCP Terraform API Token in Github
   3. Using HCP Terraform as state backend and as infrastructure management is similar. Some differences:
      1. The way log looks in HCP Terraform UI is different 
      2. For infrastructure provisioning, HCP Terraform as state backend only store state and doesn't utilize stored API key while HCP Terraform as infra management utilize stored infra API Key (or OIDC) to creates infrastructure
   4. Looks like using HCP Terraform as state backend only is going to be deprecated soon. When configuring `-backend-config` using environment variable, we cannot specify `workspaces.name`. Refer to this [issue](https://github.com/hashicorp/terraform/issues/31328). Create a backend configuration file and use this file for `backend-config=/path/to/config.remote.tfbackend`

Additional Note:
1. If we want to **pause** or do **manual approval**, Github Actions can do this through 2 ways: `Environment` and extension `trstringer/manual-approval`.
2. Have tested the `trstringer/manual-approval` method. It requires **github token** and **permissions to write issues** to work.
3. `Environment` has been tested and works at `job`-level and not at `steps` level. Meaning that to get the approval flow, different runner's environment needs to be bootstrapped.
4. Can multiple jobs be defined in 1 workflow and 1 runner so we can skip initialization? Looks like this can be done with `container` component but need to test.
   1. Results can be shared between job's runner using *artifacts*. Github actions to download and upload artifacts are available
   2. Terraform or other setup initialization can also be cached using Githb action/cache to save init time
5. We can use Github OIDC to issue short-lived token access key and avoiding long-term API access keys. Ensure to configure trust relationship for both regular and environment-managed workflows.
