Class Api.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="test"/>
  <Route Url="/users" Method="GET" Call="Users"/>
</Routes>
}

ClassMethod test() As %Status
{
  //$ZDate function https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RCOS_fzdate
  set currentDate = $ZDate($Horolog, 3)
  set obj = {"date": (currentDate)}
  write obj.%ToJSON()
  Return $$$OK
}

ClassMethod Users() As %Status
{
  set usersObj = ##class(Company.Users).%New()
  do usersObj.getUsers(.usersArray)
  write usersArray.%ToJSON()
  Return $$$OK
}

}
