Class Tables.Dancer Extends %Persistent
{

Property name As %String;

Property birthday As %String;

Property level As %String;

Storage Default
{
<Data name="DancerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>birthday</Value>
</Value>
<Value name="4">
<Value>level</Value>
</Value>
</Data>
<DataLocation>^Tables.DancerD</DataLocation>
<DefaultData>DancerDefaultData</DefaultData>
<IdLocation>^Tables.DancerD</IdLocation>
<IndexLocation>^Tables.DancerI</IndexLocation>
<StreamLocation>^Tables.DancerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod SaveDancer(dancerObj As Tables.Dancer) As %Status
{
    set obj = ##class(Tables.Dancer).%New()

    set obj.name = dancerObj.name
    set x = obj.nameIsValid(obj.name)

    set obj.birthday = dancerObj.birthday
    set x = obj.birthdayIsValid(obj.birthday)

    set obj.level = dancerObj.level
    set x = obj.levelIsValid(obj.level)

    set result = obj.%Save()
    Return result
}

ClassMethod DeleteDancer(ID As %Integer) As %Status
{
    set result = ##class(Tables.Dancer).%DeleteId(ID)
    Return result
}

ClassMethod GetDancer(ID As %Integer) As Tables.Dancer
{
    set obj = ##class(Tables.Dancer).%OpenId(ID)
    Return obj
}

ClassMethod GetDancerList() As %String
{
    set data = []
    &sql(
        DECLARE MyCursor CURSOR FOR
        SELECT ID, birthday, "level", name
        INTO :ID, :Birthday, :Level, :Name,
        FROM Tables.Dancer
    )
    
    &sql(OPEN MyCursor)   
    FOR { 
        &sql(FETCH MyCursor)
        if (SQLCODE) quit

        set obj = {"id": (ID), "name": (Name), "birthday": (Birthday), "level": (Level)}
        do data.%Push(obj)
   }
   &sql(CLOSE MyCursor)
   return data
   quit
}

Method getDancers(data) As %String
{
	set data = []
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT ID, birthday, "level", name
	    INTO :id, :birthday, :level, :name
	    FROM Tables.Dancer
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "name": (name), "level": (level),  "value": (name), "birthday": (birthday) }
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	quit
}

}
