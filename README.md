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
      1. Using HCP Terraform as state backend only
      2. Using HCP Terraform to store state and runs the infrastructure creation, thus keeping Github only for version control
   2. Both ways require storing HCP Terraform API Token in Github

Additional Note:
1. If we want to **pause** or do **manual approval**, Github Actions can do this through 2 ways: `Environment` and extension `trstringer/manual-approval`.
2. Have tested the `trstringer/manual-approval` method. It requires **github token** and **permissions to write issues** to work.
3. `Environment` has been tested and works at `job`-level and not at `steps` level. Meaning that to get the approval flow, different runner's environment needs to be bootstrapped.
4. Can multiple jobs be defined in 1 workflow and 1 runner so we can skip initialization? Looks like this can be done with `container` component but need to test.
5. We can use Github OIDC to issue short-lived token access key and avoiding long-term API access keys. Ensure to configure trust relationship for both regular and environment-managed workflows.