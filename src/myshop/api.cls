Class MyShop.Api Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/save" Method="POST" Call="Save"/>
  <Route Url="/test" Method="GET" Call="Test"/>
</Routes>
}

ClassMethod Test() As %Status
{
    write "this is test"
    Return $$$OK
}

ClassMethod Save() As %Status
{
    set obj = {}
    set obj.Name = %request.Get("name")
    set obj.Description = %request.Get("description")
    set obj.Price = %request.Get("price")
    set result = ##class(MyShop.Utils).SaveGoods(obj)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

}
