require "json"
require "http/client"
require "kemal"

class ImageSearch
  ACCESS_KEY = "Y-NsP2tnDR2D1C-TsFQfvsna6oQJUfu2Dxn0b0guLyk"  
  BASE_URL = "https://api.unsplash.com"

  def initialize
    @headers = HTTP::Headers{"Authorization" => "Client-ID #{ACCESS_KEY}"}
  end

  def search(query : String, per_page : Int32 = 30) : Array(String)
    params = { "query" => query, "per_page" => per_page.to_s }
    response = HTTP::Client.get("#{BASE_URL}/search/photos?query=#{params["query"]}&per_page=#{params["per_page"]}&client_id=#{ACCESS_KEY}")
    
    if response.status_code == 200
      json_data = JSON.parse(response.body.to_s)

image_urls = Array(String).new
data = json_data["results"].as_a

if data.is_a?(Array)
  data.each do |photo|
      image_urls << photo["urls"]["regular"].as_s
    end
else
  puts "No array of results found in JSON data"
end
      return image_urls
    else
      puts "Error fetching image search results. Status code: #{response.status_code}"
      return [] of String
    end
  end
  
end

get "/" do |env|
  query = env.params.query.to_s || "tree" 
  query = query.strip 

  image_search = ImageSearch.new
  image_results = image_search.search(query)
  
  <<-HTML
  <!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=device-width", initial-scale=1.0>
    <title> Image Search Engine </title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f2f2f2;
      }
      .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
      }
      h1{
        text-align:center;
        margin: 100px auto 50px;
        font-weight: 600;
        color: #333;
      }
      form {
        width: 90%;
        max-width: 600px;
        margin: auto;
        height: 80px;
        display: flex;
        align-items: center;
        border-radius: 8px;
      }
      input[type="text"] {
        flex: 1;
        height: 100%;
        border: 0;
        outline: 0;
        font-size: 18px;
        padding: 0 30px;
      }
      input[type="submit"] {
        padding: 0px 40px;
        height: 100%;
        background-color: #007bff;
        color: #fff;
        font-size: 18px;
        border: 0;
        outline: 0;
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
        cursor: pointer;
      }
      input[type="submit"]:hover {
        background-color: #0056b3;
      }
      button{
        background: #ff3929;
        color: #fff;
        border: 0;
        outline: 0;
        padding: 10px 20px;
        border-radius: 4px;
        margin: 10px auto 100px;
        cursor: pointer;
        display: none;
      }
      ul {
        list-style: none;
        width: 90%;
        margin: 100px auto 50px;
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        grid-gap: 20px;
      }
      img {
        width: 100%;
        height: 230px;
        obejct-fit: cover;
        border-radius: 5px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Image Search Engine</h1>
      <form id="search-form" action="/" method="get">
        <input type="text" id="query" name="query" placeholder="search anything here....">
        <input type="submit" value="Search">
      </form>
      <ul>
        #{render_image_results(image_results)}
      </ul>
      <button id="show-more-btn">Show more</button>
    </div>
  </body>
  </html>
  HTML
end

def render_image_results(image_urls : Array(String)) : String
    html = ""
    image_urls.each do |url|
      html += "<li><img src='#{url}' alt=''></li>"
    end
    return html
end

Kemal.run