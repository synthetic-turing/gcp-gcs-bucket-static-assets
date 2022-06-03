module "apis" {
  source = "../../../provisioners/terraform/modules/gcp-apis"
  services = [
    "dns.googleapis.com"
  ]
}
