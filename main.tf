# Add your code here: 

# 1. Create a subnet 
# 2. Create an Internet Gateway and attach it to the vpc
# 3. Configure routing for the Internet Gateway
# 4. Create a Security Group and inbound rules 
# 5. Uncommend (and update the value of security_group_id if required) outbound rule - it required 
# to allow outbound traffic from your virtual machine: 
# resource "aws_vpc_security_group_egress_rule" "allow_all_eggress" {
#   security_group_id = aws_security_group.security_group.id
#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = -1
# }
