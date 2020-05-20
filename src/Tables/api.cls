Class Tables.Api Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/dancers/create" Method="POST" Call="DancerSave"/>
  <Route Url="/dancers/list" Method="GET" Call="DancerGetAll"/>
  <Route Url="/dancers/delete" Method="DELETE" Call="DancerDelete"/>
  <Route Url="/dancers/one" Method="GET" Call="DancerGetOne"/>

  <Route Url="/judge/create" Method="POST" Call="JudgeSave"/>
  <Route Url="/judge/list" Method="GET" Call="JudgeGetAll"/>
  <Route Url="/judge/delete" Method="DELETE" Call="JudgeDelete"/>
  <Route Url="/judge/one" Method="GET" Call="JudgeGetOne"/>

  <Route Url="/cup/create" Method="POST" Call="CupSave"/>
  <Route Url="/cup/list" Method="GET" Call="CupGetAll"/>
  <Route Url="/cup/delete" Method="DELETE" Call="CupDelete"/>
  <Route Url="/cup/one" Method="GET" Call="CupGetOne"/>
  <Route Url="/cup/addDancer" Method="POST" Call="DancerCupAdd"/>
  <Route Url="/cup/addJudge" Method="POST" Call="JudgeCupAdd"/>
  <Route Url="/cup/addScore" Method="POST" Call="AddScore"/>
  <Route Url="/cup/results" Method="GET" Call="GetAllResults"/>
  
  
  
</Routes>
}

ClassMethod DancerSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.birthday = %request.Get("birthday")
    set obj.level = %request.Get("level")
    set saveResult = ##class(Tables.Dancer).SaveDancer(obj)
    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod DancerGetAll() As %Status
{
    Try {
        set obj = ##class(Tables.Dancer).%New()
        do obj.getDancers(.dancersArray)
        write dancersArray.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod DancerDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(Tables.Dancer).DeleteDancer(id)
    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod DancerGetOne() As %Status
{
    set id = %request.Get("id")
    try {
        set dancer = ##class(Tables.Dancer).GetDancer(id)
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

ClassMethod CupSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.lvl = %request.Get("lvl")
    set saveResult = ##class(Tables.Cup).SaveCup(obj)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod CupGetAll() As %Status
{
    Try {
        set obj = ##class(Tables.Cup).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod CupDelete() As %Status
{
    set id = %request.Get("id")
    set saveResult = ##class(Tables.Cup).DeleteCup(id)

    set result = {}
    if $$$ISERR(saveResult) {
       set result = {"result": false}
    }
    else {
       set result = {"result": true}
    }
    write result.%ToJSON()
    
    Return $$$OK
}

ClassMethod CupGetOne() As %Status
{
    set id = %request.Get("id")
    try {
        set cup = ##class(Tables.Cup).GetCup(id)
        set obj = {}
        set obj."name" = cup.name
	    set obj."lvl" = cup.lvl
        set source = obj.%ToJSON()
	    write source
        Return $$$OK
    } Catch {
        Return $$$ERROR(404)
    }
}

ClassMethod DancerCupAdd() As %Status
{
    set dancerId = %request.Get("dancer")
    set cupId = %request.Get("cup")

    set saveResult = ##class(Tables.DancerInCup).Save(dancerId, cupId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    Return $$$OK
}

ClassMethod JudgeSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.status = %request.Get("status")
    set saveResult = ##class(Tables.Judge).SaveJudge(obj)
    
    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    return $$$OK
}

ClassMethod JudgeGetAll() As %Status
{
    Try {
        set obj = ##class(Tables.Judge).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

ClassMethod JudgeCupAdd() As %Status
{
    set judgeId = %request.Get("judge")
    set cupId = %request.Get("cup")

    set saveResult = ##class(Tables.JudgeInCup).Save(judgeId, cupId)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    return $$$OK
}

ClassMethod AddScore() As %Status
{
    set judgeId = %request.Get("judge")
    set cupId = %request.Get("cup")
    set dancerId = %request.Get("dancer")
    set score = %request.Get("score")

    set saveResult = ##class(Tables.Result).Save(cupId, judgeId, dancerId, score)

    set result = {}
    if $$$ISERR(saveResult) {
        set result = {"result": false}
    }
    else {
        set result = {"result": true}
    }
    write result.%ToJSON()
    set ErrorMessage = ##class(%SYSTEM.Status).GetErrorText(saveResult)
    set result.message = ErrorMessage

    return $$$OK
}

ClassMethod GetAllResults() As %Status
{
    Try {
        set obj = ##class(Tables.Result).%New()
        do obj.getAll(.arr)
        write arr.%ToJSON()
        Return $$$OK
    } Catch {
        set result = {"result": false}
        set result.message = $ZCVT(exception.Name_" "_exception.Location, "O", "HTML")
        write result.%ToJSON()
        Return $$$ERROR(500)
    }
}

}
