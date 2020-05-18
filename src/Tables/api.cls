Class Tables.Api Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/dancers/create" Method="POST" Call="DancerSave"/>
  <Route Url="/dancers/list" Method="GET" Call="DancerGetAll"/>
  <Route Url="/dancers/delete" Method="DELETE" Call="DancerDelete"/>
  <Route Url="/dancers/one" Method="GET" Call="DancerGetOne"/>
</Routes>
}

ClassMethod DancerSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.birthday = %request.Get("birthday")
    set obj.level = %request.Get("level")
    set result = ##class(Tables.Dancer).SaveDancer(obj)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod DancerGetAll() As %Status
{
    #; try {
    #;     set list = ##class(Tables.Dancer).GetDancerList()
    #;     write list.%ToJSON()
    #;     Return $$$OK
    #; } catch {
    #;     Return $$$ERROR(500)
    #; }
    set obj = ##class(Tables.Dancer).%New()
    do obj.getDancers(.dancersArray)
    write dancersArray.%ToJSON()
    write "test"
    Return $$$OK
}

ClassMethod DancerDelete() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Tables.Dancer).DeleteDancer(id)
    if $$$ISERR(result) {
       write result
    }
    else {
       write "ok"
    }
    Return result
}

ClassMethod DancerGetOne() As %Status
{
    set id = %request.Get("id")
    try {
        set cafe = ##class(Tables.Dancer).GetDancer(id)
        set obj = {}
        set obj."name" = cafe.name
	    set obj."birthday" = cafe.birthday
        set obj."level" = cafe.level
        set source = obj.%ToJSON()
	    write source
        Return $$$OK
    } Catch {
        Return $$$ERROR(404)
    }
}

}
