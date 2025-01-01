# terraform-cicd-trial
This is trial CI/CD using Terraform.

We will be exploring ways to do this:

1. Using Github actions only without HCP terraform
   1. Add `.github/workflows/terraform.yaml` file
   2. That file contains github actions to setup terraform and run it
   3. *This action will be run on Github runner machine (linux/win/mac machine). Ensure to use standard machine and keep build time <2000mins to ensure within free tier.*
   4. Using this method, we cannot save terraform's state file in Github. Must use another backend, either s3, hcp terraform (remote), or others.
2. Using Github actions and HCP terraform
   1. This can be done in 2 ways: 
      1. Using HCP Terraform as state backend only
      2. Using HCP Terraform to store state and runs the infrastructure creation, thus keeping Github only for version control

Additional Note:
1. If we want to **pause** or do **manual approval**, Github Actions can do this through 2 ways: `Environment` and extension `trstringer/manual-approval`.
2. Have tested the `trstringer/manual-approval` method. It requires **github token** and **permissions to write issues** to work.
3. Need to test the `Environment` method
4. Can multiple jobs be defined in 1 workflow without requiring to initialize another machine? Looks like this can be done with `container` component but need to test.