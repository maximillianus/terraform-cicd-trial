# terraform-cicd-trial
This is trial CI/CD using Terraform.

We will be exploring ways to do this:

1. Using Github actions only without HCP terraform backend
   1. Add `.github/workflows/terraform.yaml` file
   2. That file contains github actions to setup terraform and run it
   3. *This action will be run on Github runner machine (linux/win/mac machine). Ensure to use standard machine and keep build time <2000mins to ensure within free tier.*
2. Using Github actions and HCP terraform backend
   1. TBD