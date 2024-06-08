resource "aws_instance" "test-servers" {
  ami           = "ami-00beae93a2d981137" 
  instance_type = "t2.nano" 
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
    Name = "test-servers"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.test-servers.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/CICD_JOB/terraform-files/ansibleplaybook.yml"
        }
  }
