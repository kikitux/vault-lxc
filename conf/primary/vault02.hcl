storage "raft" {
  path    = "/vault/raft"
  node_id = "vault02"
}
listener "tcp" {
  address = "primary-vault02:8200"
  cluster_address = "primary-vault02:8201"
  tls_cert_file = "/vault/config/ssl/vault02.pem"
  tls_key_file = "/vault/config/ssl/vault02.key"
telemetry {
  prometheus_retention_time = "30s"
#  disable_hostname         = true
#  unauthenticated_metrics_access = true
}  
}
seal "transit" {
  address            = "https://primary-unsealer:8200"
  # token is read from VAULT_TOKEN env
  # token              = ""
  disable_renewal    = ""
  //empty=false
  // Key configuration
  key_name           = "autounseal"
  mount_path         = "transit/"
  tls_ca_cert        = "/vault/config/ssl/ca.pem"
}
ui = "true"
cluster_addr = "https://primary-vault02:8201"
cluster_name = "Primary"
raw_storage_endpoint = true
log_level = "debug"