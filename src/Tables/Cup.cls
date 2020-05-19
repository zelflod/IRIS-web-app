Class Tables.Cup Extends %Persistent
{

Property name As %String;

Property lvl As %String;

Storage Default
{
<Data name="CupDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>level</Value>
</Value>
<Value name="4">
<Value>lvl</Value>
</Value>
</Data>
<DataLocation>^Tables.CupD</DataLocation>
<DefaultData>CupDefaultData</DefaultData>
<IdLocation>^Tables.CupD</IdLocation>
<IndexLocation>^Tables.CupI</IndexLocation>
<StreamLocation>^Tables.CupS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod SaveCup(newObj As Tables.Cup) As %Status
{
    set obj = ##class(Tables.Cup).%New()

    set obj.name = newObj.name
    set x = obj.nameIsValid(obj.name)

    set obj.lvl = newObj.lvl
    set x = obj.lvlIsValid(obj.lvl)

    set result = obj.%Save()
    Return result
}

ClassMethod DeleteCup(ID As %Integer) As %Status
{
    set result = ##class(Tables.Cup).%DeleteId(ID)
    Return result
}

ClassMethod GetCup(ID As %Integer) As Tables.Dancer
{
    set obj = ##class(Tables.Cup).%OpenId(ID)
    Return obj
}

Method getAll(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, lvl, name
	    INTO :ID, :Lvl, :Name
	    FROM Tables.Cup
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (ID), "lvl": (Lvl), "name": (Name), "value": (Name)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
