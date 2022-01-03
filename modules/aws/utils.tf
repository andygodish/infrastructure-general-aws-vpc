# Random string appended to the name of most 
# resources that negates name conflicts in AWS
resource "random_string" "random_append" {
  length  = 6
  special = false
}
