import ballerina/http;

listener http:Listener helloEp = new (9090);

service /payloadV on helloEp {
    //With both etag and last-modified false
    resource function get cachingBackEnd01(http:Request req) returns @http:Cache{maxAge : 5, setETag : false,
    setLastModified : false} string {
           return "Hello, World!!";}
    //With last-modified false
    resource function get cachingBackEnd02(http:Request req) returns @http:Cache{maxAge : 5,
    setLastModified : false} string {
               return "Hello, World!!";}
    //With etag false
    resource function get cachingBackEnd03(http:Request req) returns @http:Cache{setETag : false,
    mustRevalidate:false} string {
               return "Hello, World!!";}

}
