Class Api.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

/// Docs here https://cedocs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GREST_services#GREST_urlmap
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/test" Method="GET" Call="test"/>
  <Route Url="/users/get" Method="GET" Call="Users"/>
  <Route Url="/users/save" Method="POST" Call="SaveUser"/>
  <Route Url="/_spec" Method="GET" Call="SwaggerSpec" Cors="true"/>
</Routes>
}

ClassMethod SaveUser() As %Status
{
  Try {
    set requestUserObj = {}
    set requestUserObj.fname = %request.Get("fname")
    set requestUserObj.fage = %request.Get("fage")
    set result = ##class(Company.Users).SaveUser(requestUserObj)
    write result.%ToJSON()
  }
  Catch exception {
    set result = {"result": false}
    set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
    write result.%ToJSON()
  }
  Quit $$$OK
}

/// Its test
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

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/"
  Set swagger.info.title = "PackageManager Registry API"
  Set swagger.info.version = "0.1"
  Set swagger.host = "localhost:52773"
  Return ..%ProcessResult($$$OK, swagger)
}

ClassMethod %ProcessResult(pStatus As %Status = {$$$OK}, pResult As %DynamicObject = "") As %Status [ Internal ]
{
  #dim %response As %CSP.Response
  SET tSC = $$$OK
  IF $$$ISERR(pStatus) {
    SET %response.Status = 500
    SET tSC = ..StatusToJSON(pStatus, .tJSON)
    IF $isobject(tJSON) {
      SET pResult = tJSON
    } ELSE {
      SET pResult = { "errors": [ { "error": "Unknown error parsing status code" } ] }
    }
  } 
  ELSEIF pStatus=1 {
    IF '$isobject(pResult){
      SET pResult = {
      }
    }
  }
  ELSE {
    SET %response.Status = pStatus
    SET error = $PIECE(pStatus, " ", 2, *)
    SET pResult = {
      "error": (error)
    }
  }
  
  IF pResult.%Extends("%Library.DynamicAbstractObject") {
    WRITE pResult.%ToJSON()
  }
  ELSEIF pResult.%Extends("%JSON.Adaptor") {
    DO pResult.%JSONExport()
  }
  ELSEIF pResult.%Extends("%Stream.Object") {
    DO pResult.OutputToDevice()
  }
  
  QUIT tSC
}

}
