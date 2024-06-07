resource "aws_instance" "Test-Servers" {
  ami           = "ami-00beae93a2d981137" 
  instance_type = "t2.micro" 
  key_name = "newkeypairaws"
  vpc_security_group_ids= ["sg-02c3613a7b03f8ce3"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./newkeypairaws.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Test-Servers"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.New-test-server.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/terraform-files/ansibleplaybook.yml"
  }
  }
