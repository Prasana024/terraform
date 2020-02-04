# Retrieve the AZ where we want to create network resources
# This must be in the region selected on the AWS provider.
#data "aws_availability_zone" "example" {
  #name = "us-east-1a"
#}
resource "aws_vpc" "customVPC1"{
    #cidr_block = "${cidrsubnet(var.VPC_CIDR, 1, var.region_number[data.aws_availability_zone.example.region])}"
    cidr_block =  "${var.VPC_CIDR}"
    tags = {
       Name = "${var.customVPC}"
  }
}
resource "aws_subnet" "Privatesubn"{
   vpc_id ="${aws_vpc.customVPC1.id}"
   cidr_block = "${var.privateCIDR}"
  #cidr_block = "${cidrsubnet(aws_vpc.customVPC1.cidr_block, 1, var.az_number[data.aws_availability_zone.example.name_suffix])}"
   availability_zone = "${var.private_az}"
   tags = {
      name = "${var.privateSubnetName}"
    }
}
resource "aws_subnet" "publicsubnet" {
  vpc_id = "${aws_vpc.customVPC1.id}"
  cidr_block = "${var.publicCIDR}"
  map_public_ip_on_launch = true
  availability_zone = "${var.public_az}"

  tags = {
      name = "${var.publicsubnetname}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.customVPC1.id}"
}
resource "aws_route_table" "route_table1" {
  vpc_id = "${aws_vpc.customVPC1.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
resource "aws_eip" "nat_ip" {
  vpc = true
}
resource "aws_nat_gateway" "nat" {
  subnet_id = "${aws_subnet.publicsubnet.id}"
  allocation_id = "${aws_eip.nat_ip.id}"
}
resource "aws_route" "private_route" {
  route_table_id = "${aws_vpc.customVPC1.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table_association" "table_association" {
  subnet_id = "${aws_subnet.publicsubnet.id}"
  route_table_id = "${aws_route_table.route_table1.id}"
}
resource "aws_route_table_association" "table_association2" {
  subnet_id = "${aws_subnet.Privatesubn.id}"
  route_table_id = "${aws_vpc.customVPC1.default_route_table_id}"
}

resource "aws_db_subnet_group" "default" {
  subnet_ids = ["${aws_subnet.Privatesubn.id}", "${aws_subnet.publicsubnet.id}"]
}
resource "aws_security_group" "awsdb_sg" {
  name = "AWSDB SG"
  vpc_id = "${aws_vpc.customVPC1.id}"

  ingress {
      from_port = 22
      to_port = 22
      protocol = 6
      cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
}
resource "aws_db_instance" "defaultdbinstance" {
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = "db.t2.micro"
  name                 = "mypostgredb"
  username             = "foo"
  password             = "foobarbaz"
  #parameter_group_name = "defaultdbinstance.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.default.id}"
  final_snapshot_identifier = "foo1"
}
