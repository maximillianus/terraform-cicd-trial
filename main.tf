terraform {
    required_version = "1.10.3"
}
resource "terraform_data" "run_script" {
    provisioner "local-exec" {
        command = "${path.module}/hello.sh"
    }
}