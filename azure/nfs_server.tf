# # Create the Public IP for the NFS Server
# resource "azurerm_public_ip" "nfs_public_ip" {
#   name                = "nfs-public-ip"
#   resource_group_name = azurerm_resource_group.nfs.name
#   location            = azurerm_resource_group.nfs.location
#   allocation_method   = "Dynamic"

# }

# # Create the NIC for the NFS Server
# resource "azurerm_network_interface" "nfs_public_ip" {
#   name                = "nfs-server-public-nic"
#   location            = azurerm_resource_group.nfs.location
#   resource_group_name = azurerm_resource_group.nfs.name

#   ip_configuration {
#     name                          = "nfs-server-public-ip"
#     subnet_id                     = azurerm_subnet.nfs_vnet_subnet_01.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.nfs_public_ip.id
#   }
# }

# # Create the NSG for the NFS Server
# resource "azurerm_network_security_group" "nfs_server" {
#   name                = "nfs-server"
#   location            = azurerm_resource_group.nfs.location
#   resource_group_name = azurerm_resource_group.nfs.name
#   security_rule {
#     access                     = "Allow"
#     direction                  = "Inbound"
#     name                       = "rdp-ssh"
#     priority                   = 100
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     source_address_prefix      = "*"
#     destination_port_range     = "22"
#     destination_address_prefix = azurerm_network_interface.nfs_public_ip.private_ip_address
#   }
# }
# resource "azurerm_network_interface_security_group_association" "main" {
#   network_interface_id      = azurerm_network_interface.nfs_public_ip.id
#   network_security_group_id = azurerm_network_security_group.nfs_server.id
# }

# # Create the NFS Server
# resource "azurerm_linux_virtual_machine" "nfs_server" {
#   name                = "nfs-server"
#   resource_group_name = azurerm_resource_group.nfs.name
#   location            = azurerm_resource_group.nfs.location
#   size                = "Standard_B2s"
#   admin_username      = "adminuser"
#   network_interface_ids = [
#     azurerm_network_interface.nfs_public_ip.id

#   ]


#   admin_password                  = "Qwer1234567890"
#   disable_password_authentication = false

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
# }

# # Create the managed disk for the NFS Server
# resource "azurerm_managed_disk" "nfs_ssd" {
#   name                 = "nfs-ssd-01"
#   location             = azurerm_resource_group.nfs.location
#   resource_group_name  = azurerm_resource_group.nfs.name
#   storage_account_type = "Premium_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = 8
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "example" {
#   managed_disk_id    = azurerm_managed_disk.nfs_ssd.id
#   virtual_machine_id = azurerm_linux_virtual_machine.nfs_server.id
#   lun                = "10"
#   caching            = "ReadWrite"
# }
