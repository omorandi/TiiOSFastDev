var http = require("http"),
    url = require("url"),
    path = require("path"),
    fs = require("fs");

var res_dir = process.cwd();
var port = 9876;

http.createServer(function(request, response) {
    var uri = url.parse(request.url).pathname;
	console.log("[info] processing request for " + uri + "...");
    var filename = path.join(res_dir, uri);
    path.exists(filename, function(exists) {
    	if(!exists) {
    		response.writeHead(404, {"Content-Type": "text/plain"});
    		response.write("404 Not Found\n");
    		response.end();
			console.log("[error] " + filename + " not found!");
    		return;
    	}

    	fs.readFile(filename, "binary", function(err, file) {
    		if(err) {
    			response.writeHead(500, {"Content-Type": "text/plain"});
    			response.write(err + "\n");
    			response.end();
				console.log("[error] " + err);
    			return;
    		}

    		response.writeHead(200);
    		response.write(file, "binary");
    		response.end();
			console.log("[info] >>> OK!");
    	});
    });
}).listen(port);

console.log("[info] server running at http://localhost:" + port + '/');
console.log("[info] serving files from " + res_dir);
