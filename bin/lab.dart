import 'dart:async';
import 'dart:io';

const ADDR = "127.0.0.1";
const PORT = 8888;

const FORM = '''
<!DOCTYPE html>
<html>
<body>
<form action="/login" method="GET">
€
<input type="text" name="username" placeholder="Username" /><br />
<input type="password" name="password" placeholder="Password" /><br />
<input type="submit" value="Login" />
</form>
</body>
</html>
''';

void _startServer() {
  
  HttpServer.bind(ADDR, PORT).then((srv) {
    srv.listen((req) {
      
      try {
        _logHeaders(req.headers);
        
        final uri = req.uri;
        print("Uri $uri");
        
        
        uri.queryParameters.forEach((name, value) => print("$name : $value "));
        
        /*
         * 
         */
        req.response.headers.add(HttpHeaders.CONTENT_TYPE, "text/html; charset=utf-8");
        req.response
          ..write(FORM)
          ..close();
        
      } catch (e, stackTrace) {
        print("Error on managemt request $req $e \n $stackTrace");
        
      }
      
    },
    onError: (error) {
      print("Error on request stream $error");
    });
  });
}

void _logHeaders(HttpHeaders hs) {
  
  hs.forEach((name, values) {
    
   var s = "$name ";
   
   values.forEach((value) {
     s = "$s $value";
   });
   
   print(s);
    
  });
  
}

void main() {
  
  _startServer();
  
}


