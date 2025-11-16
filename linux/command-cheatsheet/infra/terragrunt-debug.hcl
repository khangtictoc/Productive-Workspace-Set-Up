locals {
  region   = include.root.locals.region
  _debug = run_cmd("bash", "-c", "echo DEBUG='${jsonencode(local.region)}'")
}