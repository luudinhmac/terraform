terraform {
  cloud {
    organization = "macluu"

    workspaces {
      name = "tf-series-backend-remote-cloud"
    }
  }
}
