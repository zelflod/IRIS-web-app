Class Company.DataProvider Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
  set users = ##class(Company.Users).GetData()
  write users.%ToJSON()
  Quit $$$OK
}

}
