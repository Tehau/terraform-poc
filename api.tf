data "http" "example" {
  url = "https://jsonplaceholder.typicode.com/posts"
  #url = "https://api.github.com/" #401
  
  # Optional request headers
  request_headers {
    "Accept" = "application/json"
    #"Accept" = "text/*"
  }
  
}

output "result_http" {
  value = "${data.http.example.body}"
}