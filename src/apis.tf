module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules//google-enable-apis?ref=9201b9f"
  services = [
    "dns.googleapis.com"
  ]
}
