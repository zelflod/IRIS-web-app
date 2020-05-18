Class PackageSample.ObjectScript
{

ClassMethod Test() As %Status
{
    set a=42

    #; set obj = ##class(FCE.Person).%New()
    #; set obj.name = requestUserObj.fname
    #; set obj.age = requestUserObj.fage
    #; set saveResult = obj.%Save()

    return "It works!"
}

}
