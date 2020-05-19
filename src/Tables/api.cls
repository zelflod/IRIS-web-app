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

ClassMethod CupSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.lvl = %request.Get("lvl")
    set result = ##class(Tables.Cup).SaveCup(obj)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod CupGetAll() As %Status
{
    set obj = ##class(Tables.Cup).%New()
    do obj.getAll(.arr)
    write arr.%ToJSON()
    Return $$$OK
}

ClassMethod CupDelete() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Tables.Cup).DeleteCup(id)
    if $$$ISERR(result) {
       write result
    }
    else {
       write "ok"
    }
    Return result
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

    set result = ##class(Tables.DancerInCup).Save(dancerId, cupId)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod JudgeSave() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.status = %request.Get("status")
    set result = ##class(Tables.Judge).SaveJudge(obj)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod JudgeGetAll() As %Status
{
    set obj = ##class(Tables.Judge).%New()
    do obj.getAll(.arr)
    write arr.%ToJSON()
    Return $$$OK
}

ClassMethod JudgeCupAdd() As %Status
{
    set judgeId = %request.Get("judge")
    set cupId = %request.Get("cup")

    set result = ##class(Tables.JudgeInCup).Save(judgeId, cupId)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod AddScore() As %Status
{
    set judgeId = %request.Get("judge")
    set cupId = %request.Get("cup")
    set dancerId = %request.Get("dancer")
    set score = %request.Get("score")

    set result = ##class(Tables.Result).Save(cupId, judgeId, dancerId, score)
    if $$$ISERR(result) {
        write result
    }
    else {
        write "ok"
    }
    Return result
}

ClassMethod GetAllResults() As %Status
{
    set obj = ##class(Tables.Result).%New()
    do obj.getAll(.arr)
    write arr.%ToJSON()
    Return $$$OK
}

}
