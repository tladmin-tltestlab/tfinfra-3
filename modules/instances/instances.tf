#uncomment this resource block to create a resource for the manually created GCE instance
resource "google_compute_instance" "manual_vm-1" {
  count        = var.enable_compute_lab ? 1 : 0
  name         = "tf-instance-1"
  zone         = var.zone
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = var.instance_network
     access_config {
      # Uncomment access_config block to allocate an external emphermal IP to the instance
     }
  }
  tags                      = ["web-server"] # This connects the VM to the firewall rule
  metadata_startup_script   = <<-EOT
        #!/bin/bash
        apt-get update
        apt-get install -y apache2

        # Create a "Matrix" style HTML page
    cat <<EOF > /var/www/html/index.html
    <!DOCTYPE html>
    <html>
    <head>
    <title>System Terminal</title>
    <style>
      body {
        background-color: black;
        color: #00FF41; /* Classic Matrix Green */
        font-family: 'Courier New', Courier, monospace;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        overflow: hidden;
      }
      .container {
        text-align: center;
        border: 1px solid #00FF41;
        padding: 40px;
        box-shadow: 0 0 15px #00FF41;
      }
      h1 {
        font-size: 3rem;
        text-transform: uppercase;
        letter-spacing: 5px;
        animation: pulse 2s infinite;
      }
      @keyframes pulse {
        0% { text-shadow: 0 0 5px #00FF41; }
        50% { text-shadow: 0 0 20px #00FF41, 0 0 30px #003300; }
        100% { text-shadow: 0 0 5px #00FF41; }
      }
    </style>
    </head>
    <body>
      <div class="container">
        <h1>Hello George</h1>
        <p>> Initializing system... SUCCESS</p>
        <p>> Connection established via Terraform</p>
      </div>
    </body>
    </html>
    EOF

        # Ensure Apache starts on boot and is running
        systemctl enable apache2
        systemctl start apache2
        EOT
  allow_stopping_for_update = true
  # ... define the rest of the config to match the real resource ...
}



